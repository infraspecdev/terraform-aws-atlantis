output "alb_listener_arn" {
  description = "ARN of the Application load balancer"
  value       = aws_lb_listener.https_listener.arn
}
