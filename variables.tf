variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-south-1"
}

variable "atlantis_repo_allowlist" {
  description = "Comma delimited string containing repos to use atlantis"
  type        = string
  default     = "github.com/Rahul-4480/test-atlantis"
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

variable "vpc_cidr_block" {
  description = "VPC CIDR block for creating security groups."
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
