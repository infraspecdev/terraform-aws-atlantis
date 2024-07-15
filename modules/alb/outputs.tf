output "alb_listener_arn" {
  description = "ARN of the Application load balancer"
  value       = aws_lb_listener.https_listener.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name
}
