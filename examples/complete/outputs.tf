output "github_webhook_url" {
  description = "The URL for GitHub webhook"
  value       = format("https://%s/events", module.atlantis.atlantis_url)
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = var.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = var.private_subnet_ids
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id
}

output "authorized_javascript_origin" {
  description = "The base URL for your application that is authorized to use JavaScript for OAuth requests."
  value       = format("https://%s", module.atlantis.atlantis_url)
}

output "authorized_redirect_uri" {
  description = "The redirect URI used by your OAuth provider to return responses to your application."
  value       = format("https://%s/oauth2/idpresponse", module.atlantis.atlantis_url)
}
