variable "service_name" {
  description = "(Required) Name of the service."
  type        = string
  default     = "atlantis"
}

variable "task_definition_family" {
  type        = string
  description = "(Required) A unique name for your task definition."
  default     = "atlantis"
}

variable "container_definitions" {
  type        = string
  description = "JSON encoded list of container definition assigned to ecs task"
}

variable "vpc_id" {
  description = "VPC ID for creating ECS Resources."
  type        = string
}

variable "launch_type" {
  description = "ECS launch type"
  type = object({
    type   = string
    cpu    = optional(number)
    memory = optional(number)
  })
}

variable "endpoint_details" {
  type = object({
    lb_listener_arn = string
    domain_url      = string
  })
  description = "Endpoint details"
  default     = null
}

variable "service_desired_count" {
  type        = number
  description = "(Optional) Number of instances of the task definition to place and keep running."
}

variable "launch_template_instance_type" {
  description = "(Optional) The type of the instance."
  type        = string
}

variable "launch_template_key_name" {
  description = "(Optional) The key name to use for the instance."
  type        = string
}

variable "launch_template_image_id" {
  description = "(Optional) The AMI from which to launch the instance."
  type        = string
  default     = "ami-0352888a5fa748216"
}

variable "auto_scaling_group_desired_capacity" {
  description = "(Optional) Number of Amazon EC2 instances that should be running in the group."
  type        = number
}

variable "auto_scaling_group_min_size" {
  description = "(Required) Minimum size of the Auto Scaling Group"
  type        = number
}

variable "auto_scaling_group_max_size" {
  description = "(Required) Maximum size of the Auto Scaling Group."
  type        = number
}

variable "private_subnet_ids" {
  description = "List of Private subnet ids to deploy containers."
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block for creating security group."
  type        = string
}

variable "launch_template_name_prefix" {
  description = "Name prefix for the launch template resource."
  type        = string
  default     = "ecs-"
}

variable "authenticate_oidc_details" {
  description = "Contains OIDC authentication details (endpoint, client ID, client secret) for Atlantis server integration."
  type = object({
    oidc_endpoint = string
    client_id     = string
    client_secret = string
  })
}

variable "cluster_arn" {
  description = "(Required) ARN value of the default ecs cluster"
  type        = string
}
