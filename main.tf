data "aws_ssm_parameter" "environment" {
  for_each = toset(local.secret_variables)
  name     = "/atlantis/${each.key}"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_ecs_cluster" "default" {
  cluster_name = var.ecs_cluster_name
}

data "aws_iam_policy_document" "ecs_task_assume_policy" {
  statement {
    actions = local.ecs_task_assume_policy_actions
    principals {
      type        = local.ecs_task_assume_policy_principal_type
      identifiers = local.ecs_task_assume_policy_principal_identifiers
    }
  }
}

data "aws_acm_certificate" "base_domain_certificate" {
  domain   = local.base_domain
  statuses = local.acm_certificate_statuses
}

data "aws_route53_zone" "zone" {
  name = local.base_domain
}

module "ecs_deployment" {
  source  = "infraspecdev/ecs-deployment/aws"
  version = "3.0.1"

  cluster_name = data.aws_ecs_cluster.default.cluster_name
  vpc_id       = var.vpc_id

  task_definition = {
    family             = local.ecs_task_definition_family
    network_mode       = local.task_definition_network_mode
    execution_role_arn = aws_iam_role.task_role.arn
    container_definitions = [{
      name              = local.ecs_container_definations_name
      image             = var.atlantis_docker_image
      container_port    = local.container_port
      environment       = local.env_variables
      secrets           = local.secrets
      memoryReservation = local.container_memory_reservation
      portMappings = [
        {
          containerPort = local.container_port
          hostPort      = local.container_port
        }
      ]
    }]
    cpu    = try(var.ecs_launch_type_cpu, null)
    memory = try(var.ecs_launch_type_memory, null)

    volume = {}
  }
  service = {
    name          = local.ecs_service_name
    desired_count = var.ecs_service_desired_count != null ? var.ecs_service_desired_count : local.default_desired_count
    load_balancer = [{
      container_name = local.ecs_container_definations_name
      container_port = local.container_port
      target_group   = local.target_group_name
    }]

    network_configuration = {
      subnets         = var.private_subnet_ids
      security_groups = [aws_security_group.ecs.id]
    }
  }

  load_balancer = {
    name                = local.alb_system_name
    internal            = local.load_balancer_internal
    subnets_ids         = var.public_subnet_ids
    security_groups_ids = [aws_security_group.alb.id]

    target_groups = {
      atlantis-target-group = {
        name        = format("%s-%s-ip", local.alb_system_name, terraform.workspace)
        port        = local.container_port
        protocol    = local.target_group_protocol
        target_type = local.alb_ip_target_type
      }
    }

    listeners = {
      https-listener = {
        protocol        = local.listener_protocol
        port            = local.listener_port
        certificate_arn = data.aws_acm_certificate.base_domain_certificate.arn

        default_action = [
          {
            type         = local.default_action_type
            target_group = local.target_group_name
            fixed_response = {
              content_type = local.fixed_response_content_type
              message_body = local.fixed_response_message_body
              status_code  = local.fixed_response_status_code
            }
          }
        ]
      }
    }

    listener_rules = {
      https-listener-rules = {
        listener = local.listener_name
        priority = local.listener_priority

        condition = [
          {
            host_header = {
              values = [var.atlantis_url]
            }
          }
        ]

        action = [
          {
            type = local.authenticate_oidc_type

            authenticate_oidc = {
              authorization_endpoint     = local.authenticate_oidc_authorization_endpoint
              token_endpoint             = local.authenticate_oidc_token_endpoint
              user_info_endpoint         = local.authenticate_oidc_user_info_endpoint
              issuer                     = local.authenticate_oidc_issuer
              session_cookie_name        = format("TOKEN-OIDC-%s", data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value)
              scope                      = local.authenticate_oidc_scope
              on_unauthenticated_request = local.authenticate_oidc_on_unauthenticated_request
              client_id                  = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value
              client_secret              = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_SECRET"].value
            }
          },
          {
            target_group = local.target_group_name
            type         = local.forward_action_type
          }
        ]
      },
      http-listener-rules = {
        listener = local.listener_name
        priority = local.http_listener_priority

        condition = [
          {
            path_pattern = {
              values = local.path_pattern_values
            }
          },
          {
            http_request_method = {
              values = local.http_request_method_values
            }
          },
          {
            host_header = {
              values = [var.atlantis_url]
            }
          }
        ]

        action = [
          {
            target_group = local.target_group_name
            type         = local.forward_action_type
          }
        ]
      }
    }
  }

  create_capacity_provider = local.create_capacity_provider
}
