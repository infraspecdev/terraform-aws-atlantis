locals {
  atlantis_url                    = "${var.sub_domain}.${var.base_domain}"
  ecs_container_definations_image = "ghcr.io/runatlantis/atlantis:v0.23.1"

  env_variables = {
    ATLANTIS_ATLANTIS_URL                = "https://${local.atlantis_url}"
    ATLANTIS_REPO_ALLOWLIST              = var.atlantis_repo_allowlist
    ATLANTIS_WRITE_GIT_CREDS             = "true"
    ATLANTIS_DISABLE_APPLY_ALL           = "true"
    ATLANTIS_SILENCE_NO_PROJECTS         = "true"
    ATLANTIS_PORT                        = "4141"
    ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT = "true"
  }

  secret_variables = [
    "ATLANTIS_GH_USER",
    "ATLANTIS_GH_TOKEN",
    "ATLANTIS_GH_WEBHOOK_SECRET",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY"
  ]

  secrets = {
    for item in local.secret_variables :
    item => data.aws_ssm_parameter.environment[item].arn
  }
}
