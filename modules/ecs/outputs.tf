output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = aws_ecs_task_definition.this.arn
}

output "endpoint_details" {
  description = "Details of the ECS service endpoint"
  value = {
    lb_listener_arn = var.endpoint_details.lb_listener_arn
    domain_url      = var.endpoint_details.domain_url
  }
}
