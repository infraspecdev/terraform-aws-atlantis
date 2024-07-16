output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs.ecs_service_name
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = module.ecs.ecs_task_definition_arn
}

output "github_webhook_url" {
  description = "The URL for GitHub webhook"
  value       = format("%s/events", module.ecs.endpoint_details.domain_url)
}


output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = var.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = var.private_subnet_ids
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id
}
