variable "vpc_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of IPv4 CIDR block for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of IPv4 CIDR block for private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "region" {
  description = "Region for creating resources"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "List of Availability zone where the subnet must reside."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
