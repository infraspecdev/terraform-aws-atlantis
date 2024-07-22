locals {
  google_oidc_endpoint            = "https://accounts.google.com"
  thumbprint_list                 = ["e252aa6e92432f32cbc1b182056627c239652678"]
  container_port                  = 4141
  launch_type                     = "EC2"
  ecs_container_definations_name  = "atlantis"
  alb_system_name                 = "atlantis"
  atlantis_url                    = "${var.sub_domain}.${var.base_domain}"
  ecs_container_definations_image = "ghcr.io/runatlantis/atlantis:v0.23.1"

  env_variables = {
    ATLANTIS_GH_USER                     = var.atlantis_gh_user
    ATLANTIS_URL                         = "https://${local.atlantis_url}"
    ATLANTIS_REPO_ALLOWLIST              = var.atlantis_repo_allowlist
    ATLANTIS_WRITE_GIT_CREDS             = "true"
    ATLANTIS_DISABLE_APPLY_ALL           = "true"
    ATLANTIS_SILENCE_NO_PROJECTS         = "true"
    ATLANTIS_PORT                        = "4141"
    ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT = "true"
    ATLANTIS_GOOGLE_REDIRECT_URI         = "https://${local.atlantis_url}/oauth2/idpresponse"
  }

  secret_variables = [
    "ATLANTIS_GH_TOKEN",
    "ATLANTIS_GH_WEBHOOK_SECRET",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "ATLANTIS_GOOGLE_CLIENT_ID",
    "ATLANTIS_GOOGLE_CLIENT_SECRET"
  ]

  secrets = {
    for item in local.secret_variables :
    item => data.aws_ssm_parameter.environment[item].arn
  }
}
