locals {
  container_defn_object = jsondecode(var.container_definitions)
  container_definitions = jsonencode([
    for definition in local.container_defn_object : merge({
      for key, value in definition :
      key => try(
        try(toset(value), [
          for k, v in value : {
            name                                     = k
            key == "secrets" ? "valueFrom" : "value" = v
        }]),
      value)
      },
      lookup(definition, "portMappings", null) == null ? {
        portMappings = [
          {
            containerPort = tonumber(definition.container_port)
            hostPort      = tonumber(definition.container_port)
          }
        ]
      } : {}
    )
  ])

  first_container                          = local.container_defn_object[0]
  main_container_name                      = local.first_container.name
  main_container_port                      = local.first_container.container_port
  iam_role_policy_arn                      = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  iam_instance_role_name_prefix            = "ecs-instance-role"
  iam_instance_profile_name_prefix         = "ecs-instance-profile"
  task_definition_network_mode             = "awsvpc"
  alb_ip_target_type                       = "ip"
  authenticate_oidc_issuer                 = "https://accounts.google.com"
  authenticate_oidc_user_info_endpoint     = "https://openidconnect.googleapis.com/v1/userinfo"
  authenticate_oidc_token_endpoint         = "https://oauth2.googleapis.com/token"
  authenticate_oidc_authorization_endpoint = "https://accounts.google.com/o/oauth2/v2/auth"
  launch_template_image_id                 = "ami-0352888a5fa748216"
  launch_template_instance_type            = "t2.micro"
}
