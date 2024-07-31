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

variable "base_domain" {
  description = "Base domain for the Atlantis server"
  type        = string
}

variable "sub_domain" {
  description = "Subdomain for the Atlantis server"
  type        = string
}
