variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "atlantis_gh_user" {
  description = "GitHub username for Atlantis"
  type        = string
}

variable "atlantis_repo_allowlist" {
  description = "GitHub repository allowlist for Atlantis"
  type        = string
}

variable "container_memory_reservation" {
  description = "Memory reservation for the container"
  type        = number
}

variable "base_domain" {
  description = "Base domain for the Atlantis server"
  type        = string
}

variable "sub_domain" {
  description = "Subdomain for the Atlantis server"
  type        = string
}

variable "launch_template_key_name" {
  description = "Key name for the launch template"
  type        = string
}

variable "ecs_auto_scaling_group_min_size" {
  description = "Minimum size of the ECS auto-scaling group"
  type        = number
}

variable "ecs_auto_scaling_group_max_size" {
  description = "Maximum size of the ECS auto-scaling group"
  type        = number
}
