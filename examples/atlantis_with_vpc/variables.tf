variable "atlantis_repo_allowlist" {
  description = "Comma delimited string containing repos to use atlantis"
  type        = string
  default     = "github.com/<user-name>/<repository_name>"
}

variable "base_domain" {
  description = "Your base domain with acm certificate attached to it."
  type        = string
}

variable "sub_domain" {
  description = "Your desired sub domain"
  type        = string
}

variable "system_name" {
  description = "Name of the System"
  type        = string
}

variable "ecs_cluster_name" {
  description = "(Required) Name of the cluster."
  type        = string
}

variable "ecs_service_name" {
  description = "(Required) Name of the service."
  type        = string
}

variable "ecs_task_definition_family" {
  description = "(Required) A unique name for your task definition."
  type        = string
}

variable "ecs_launch_type_cpu" {
  description = "EC2 instance CPU"
  type        = number
}

variable "ecs_launch_type_memory" {
  description = "EC2 instance memory"
  type        = number
}

variable "ecs_container_definations_name" {
  description = "Name of the ECS container defination."
  type        = string
}

variable "launch_template_key_name" {
  description = "(Optional) The key name to use for the instance."
  type        = string
}

variable "availability_zones" {
  description = "List of Availability zone where the subnet must reside."
  type        = list(string)
}
