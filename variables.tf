variable "atlantis_repo_allowlist" {
  description = "Comma delimited string containing repos to use atlantis"
  type        = string
}

variable "base_domain" {
  description = "Your base domain with acm certificate attached to it."
  type        = string
}

variable "sub_domain" {
  description = "Your desired sub domain"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for creating Atlantis Resources."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public subnet ids to deploy application load balancers."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of Private subnet ids to deploy Atlantis server."
  type        = list(string)
}

variable "ecs_launch_type_cpu" {
  description = "EC2 instance CPU"
  type        = number
  default     = null
}

variable "ecs_launch_type_memory" {
  description = "EC2 instance memory"
  type        = number
  default     = null
}

variable "container_memory_reservation" {
  description = "Soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit"
  type        = number
}

variable "launch_template_key_name" {
  description = "The key name to use for the instance."
  type        = string
}

variable "ecs_service_desired_count" {
  type        = number
  description = "(Optional) Number of instances of the task definition to place and keep running."
  default     = null
}

variable "ecs_launch_template_instance_type" {
  description = "(Optional) The type of the instance."
  type        = string
  default     = null
}

variable "ecs_launch_template_image_id" {
  description = "(Optional) The AMI from which to launch the instance."
  type        = string
  default     = null
}

variable "ecs_auto_scaling_group_desired_capacity" {
  description = "(Optional) Number of Amazon EC2 instances that should be running in the group."
  type        = number
  default     = null
}

variable "ecs_auto_scaling_group_min_size" {
  description = "(Required) Minimum size of the Auto Scaling Group"
  type        = number
}

variable "ecs_auto_scaling_group_max_size" {
  description = "(Required) Maximum size of the Auto Scaling Group."
  type        = number
}

variable "atlantis_gh_user" {
  description = "The GitHub username used by Atlantis to access repositories"
  type        = string
}
