variable "atlantis_repo_allowlist" {
  description = "Comma delimited string containing repos to use atlantis"
  type        = string
}

variable "atlantis_url" {
  description = "Full URL for the Atlantis server"
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

variable "thumbprint_list" {
  description = "The thumbprint of the OIDC provider"
  type        = list(string)
  default     = ["e252aa6e92432f32cbc1b182056627c239652678"]
}

variable "atlantis_docker_image" {
  description = "The Docker image to use for the Atlantis server"
  type        = string
  default     = "ghcr.io/runatlantis/atlantis:v0.28.5"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "default"
}
