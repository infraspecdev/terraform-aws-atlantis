locals {
  google_oidc_endpoint                         = "https://accounts.google.com"
  container_port                               = 4141
  alb_ip_target_type                           = "ip"
  ecs_container_definations_name               = "atlantis"
  alb_system_name                              = "atlantis"
  domain_parts                                 = split(".", var.atlantis_url)
  base_domain                                  = join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts)))
  sub_domain                                   = join(".", slice(local.domain_parts, 0, length(local.domain_parts) - 2))
  ecs_task_definition_family                   = "atlantis"
  task_definition_network_mode                 = "awsvpc"
  load_balancer_internal                       = "false"
  ecs_service_name                             = "atlantis"
  container_memory_reservation                 = 10
  authenticate_oidc_issuer                     = "https://accounts.google.com"
  authenticate_oidc_user_info_endpoint         = "https://openidconnect.googleapis.com/v1/userinfo"
  authenticate_oidc_token_endpoint             = "https://oauth2.googleapis.com/token"
  authenticate_oidc_authorization_endpoint     = "https://accounts.google.com/o/oauth2/v2/auth"
  ecs_task_assume_policy_actions               = ["sts:AssumeRole"]
  ecs_task_assume_policy_principal_type        = "Service"
  ecs_task_assume_policy_principal_identifiers = ["ecs-tasks.amazonaws.com"]
  default_desired_count                        = 1
  target_group_name                            = "atlantis-target-group"
  acm_certificate_name                         = "atlantis-domain"
  target_group_protocol                        = "HTTP"
  listener_protocol                            = "HTTPS"
  listener_port                                = 443
  default_action_type                          = "fixed-response"
  fixed_response_content_type                  = "application/json"
  fixed_response_message_body                  = "Unauthorised"
  fixed_response_status_code                   = 404
  listener_name                                = "https-listener"
  listener_priority                            = 10
  authenticate_oidc_type                       = "authenticate-oidc"
  authenticate_oidc_scope                      = "openid email"
  authenticate_oidc_on_unauthenticated_request = "authenticate"
  forward_action_type                          = "forward"
  http_listener_priority                       = 1
  path_pattern_values                          = ["/events"]
  http_request_method_values                   = ["POST"]
  create_capacity_provider                     = false

  env_variables = [
    {
      name  = "ATLANTIS_GH_USER"
      value = var.atlantis_gh_user
    },
    {
      name  = "ATLANTIS_URL"
      value = "https://${var.atlantis_url}"
    },
    {
      name  = "ATLANTIS_REPO_ALLOWLIST"
      value = var.atlantis_repo_allowlist
    },
    {
      name  = "ATLANTIS_WRITE_GIT_CREDS"
      value = "true"
    },
    {
      name  = "ATLANTIS_DISABLE_APPLY_ALL"
      value = "true"
    },
    {
      name  = "ATLANTIS_SILENCE_NO_PROJECTS"
      value = "true"
    },
    {
      name  = "ATLANTIS_PORT"
      value = tostring(local.container_port)
    },
    {
      name  = "ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT"
      value = "true"
    },
    {
      name  = "ATLANTIS_GOOGLE_REDIRECT_URI"
      value = "https://${var.atlantis_url}/oauth2/idpresponse"
    }
  ]

  secret_variables = [
    "ATLANTIS_GH_TOKEN",
    "ATLANTIS_GH_WEBHOOK_SECRET",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "ATLANTIS_GOOGLE_CLIENT_ID",
    "ATLANTIS_GOOGLE_CLIENT_SECRET"
  ]

  secrets = [
    for item in local.secret_variables : {
      name      = item
      valueFrom = data.aws_ssm_parameter.environment[item].arn
    }
  ]
}
