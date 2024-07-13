locals {
  container_defn_object = jsondecode(var.container_definitions)
  container_definitions = jsonencode([
    for definition in local.container_defn_object : merge({
      for key, value in definition :
      key => try(
        # handle value that is a list
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
      } : {},
      try(lookup(definition, "logConfiguration", null) == null ? {
        logConfiguration = {
          logDriver = "awslogs"

          options = {
            awslogs-region        = var.region
            awslogs-stream-prefix = definition.name
            awslogs-group         = aws_cloudwatch_log_group.this.name
          }
        }
      } : {}, {})

    )
  ])

  first_container                  = local.container_defn_object[0]
  main_container_name              = local.first_container.name
  main_container_port              = local.first_container.container_port
  iam_role_policy_arn              = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  iam_instance_role_name_prefix    = "ecs-instance-role"
  iam_instance_profile_name_prefix = "ecs-instance-profile"
  task_definition_network_mode     = "awsvpc"
  alb_instance_target_type         = "instance"
  alb_ip_target_type               = "ip"
}
