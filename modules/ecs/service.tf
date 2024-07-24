resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_arn
  launch_type     = var.launch_type.type
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.service_desired_count != null ? var.service_desired_count : 1

  dynamic "load_balancer" {
    for_each = var.endpoint_details != null ? [1] : []

    content {
      container_name   = local.main_container_name
      container_port   = local.main_container_port
      target_group_arn = aws_lb_target_group.ip_target[0].arn
    }
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.this.id]
    assign_public_ip = false
  }

  depends_on = [
    aws_lb_listener_rule.events_post_rule,
    aws_lb_listener_rule.default_rule,
  ]
}
