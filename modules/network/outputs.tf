output "vpc_id" {
  description = "The ID of VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The ID of the public subnets."
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "The ID of the private subnets."
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "vpc_cidr_block" {
  description = "CIDR block range of the VPC"
  value       = aws_vpc.main.cidr_block
}
