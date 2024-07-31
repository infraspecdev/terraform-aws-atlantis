locals {
  google_oidc_endpoint                     = "https://accounts.google.com"
  thumbprint_list                          = ["e252aa6e92432f32cbc1b182056627c239652678"]
  container_port                           = 4141
  alb_ip_target_type                       = "ip"
  ecs_container_definations_name           = "atlantis"
  alb_system_name                          = "atlantis"
  atlantis_url                             = "${var.sub_domain}.${var.base_domain}"
  ecs_container_definations_image          = "ghcr.io/runatlantis/atlantis:v0.23.1"
  ecs_task_definition_family               = "atlantis"
  task_definition_network_mode             = "awsvpc"
  load_balancer_internal                   = "false"
  ecs_service_name                         = "atlantis"
  container_memory_reservation             = 10
  authenticate_oidc_issuer                 = "https://accounts.google.com"
  authenticate_oidc_user_info_endpoint     = "https://openidconnect.googleapis.com/v1/userinfo"
  authenticate_oidc_token_endpoint         = "https://oauth2.googleapis.com/token"
  authenticate_oidc_authorization_endpoint = "https://accounts.google.com/o/oauth2/v2/auth"

  env_variables = [
    {
      name  = "ATLANTIS_GH_USER"
      value = var.atlantis_gh_user
    },
    {
      name  = "ATLANTIS_URL"
      value = "https://${local.atlantis_url}"
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
      value = "4141"
    },
    {
      name  = "ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT"
      value = "true"
    },
    {
      name  = "ATLANTIS_GOOGLE_REDIRECT_URI"
      value = "https://${local.atlantis_url}/oauth2/idpresponse"
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
