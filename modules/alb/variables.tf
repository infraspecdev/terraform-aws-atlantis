variable "system_name" {
  type        = string
  description = "System name"
}

variable "load_balancer_internal" {
  type        = bool
  description = "(Optional) If true, the LB will be internal."
  default     = false
}

variable "base_domain" {
  type        = string
  description = "Base domain"
}

variable "load_balancer_type" {
  description = "(Optional) Type of load balancer to create."
  type        = string
  default     = "application"
}

variable "ssl_policy" {
  type        = string
  description = "(Optional) Name of the SSL Policy for the listener."
  default     = "ELBSecurityPolicy-2016-08"
}

variable "endpoints" {
  description = "List of endpoints that will expose the load balancer"
  type        = list(any)
}

variable "public_subnet_ids" {
  description = "List of public subnets for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for creating the security group"
  type        = string
}
