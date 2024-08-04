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

variable "atlantis_url" {
  description = "Full URL for the Atlantis server"
  type        = string
}

# Optional variables defination
variable "thumbprint_list" {
  description = "List of thumbprints for the OIDC provider"
  type        = list(string)
}

variable "atlantis_docker_image" {
  description = "The Docker image to use for the Atlantis server"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}
