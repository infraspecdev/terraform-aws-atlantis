module "ecs_deployment" {
  source  = "infraspecdev/ecs-deployment/aws"
  version = "2.1.0"

  cluster_name = data.aws_ecs_cluster.default.cluster_name
  vpc_id       = var.vpc_id

  task_definition = {
    family             = local.ecs_task_definition_family
    network_mode       = local.task_definition_network_mode
    execution_role_arn = aws_iam_role.task_role.arn
    container_definitions = [{
      name              = local.ecs_container_definations_name
      image             = local.ecs_container_definations_image
      container_port    = local.container_port
      environment       = local.env_variables
      secrets           = local.secrets
      command           = ["server"]
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
  }
  service = {
    name          = local.ecs_service_name
    desired_count = var.ecs_service_desired_count != null ? var.ecs_service_desired_count : 1
    load_balancer = [{
      container_name = local.ecs_container_definations_name
      container_port = local.container_port
      target_group   = "target-group"
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
      target-group = {
        name        = format("%s-%s-ip", local.alb_system_name, terraform.workspace)
        port        = local.container_port
        protocol    = "HTTP"
        target_type = local.alb_ip_target_type
      }
    }

    listeners = {
      https-listener = {
        protocol        = "HTTPS"
        port            = 443
        certificate_arn = data.aws_acm_certificate.base_domain_certificate.arn

        default_action = [
          {
            type         = "fixed-response"
            target_group = "target-group"
            fixed_response = {
              content_type = "application/json"
              message_body = "Unauthorised"
              status_code  = 404
            }
          }
        ]
      }
    }

    listener_rules = {
      https-listener-rules = {
        listener = "https-listener"
        priority = 10

        condition = [
          {
            host_header = {
              values = [local.atlantis_url]
            }
          }
        ]

        action = [
          {
            target_group = ""
            type         = "authenticate-oidc"

            authenticate_oidc = {
              authorization_endpoint     = local.authenticate_oidc_authorization_endpoint
              token_endpoint             = local.authenticate_oidc_token_endpoint
              user_info_endpoint         = local.authenticate_oidc_user_info_endpoint
              issuer                     = local.authenticate_oidc_issuer
              session_cookie_name        = format("TOKEN-OIDC-%s", data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value)
              scope                      = "openid email"
              on_unauthenticated_request = "authenticate"
              client_id                  = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value
              client_secret              = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_SECRET"].value
            }
          },
          {
            target_group = "target-group"
            type         = "forward"
          }
        ]
      },
      http-listener-rules = {
        listener = "https-listener"
        priority = 1

        condition = [
          {
            path_pattern = {
              values = ["/events"]
            }
          },
          {
            http_request_method = {
              values = ["POST"]
            }
          },
          {
            host_header = {
              values = [local.atlantis_url]
            }
          }
        ]

        action = [
          {
            target_group = "target-group"
            type         = "forward"
          }
        ]
      }
    }
  }

  create_capacity_provider = false
}
