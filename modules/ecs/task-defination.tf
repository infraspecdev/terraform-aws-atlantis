resource "aws_ecs_task_definition" "this" {
  family                   = var.task_definition_family
  network_mode             = local.task_definition_network_mode
  requires_compatibilities = [var.launch_type.type]
  execution_role_arn       = aws_iam_role.task_role.arn
  container_definitions    = local.container_definitions
  cpu                      = try(var.launch_type.cpu, null)
  memory                   = try(var.launch_type.memory, null)
}
