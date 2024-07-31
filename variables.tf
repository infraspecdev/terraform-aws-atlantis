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

variable "ecs_service_desired_count" {
  type        = number
  description = "(Optional) Number of instances of the task definition to place and keep running."
  default     = null
}

variable "atlantis_gh_user" {
  description = "The GitHub username used by Atlantis to access repositories"
  type        = string
}
