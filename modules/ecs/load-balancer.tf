resource "aws_lb_target_group" "ip_target" {
  count       = var.endpoint_details != null ? 1 : 0
  name        = format("%s-%s-ip", var.service_name, terraform.workspace)
  port        = local.main_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = local.alb_ip_target_type

  health_check {
    protocol            = "HTTP"
    interval            = 10
    unhealthy_threshold = 6
    matcher             = "200,301-399"
  }
}

resource "aws_lb_listener_rule" "default_rule" {
  count        = var.endpoint_details != null ? 1 : 0
  listener_arn = var.endpoint_details.lb_listener_arn
  priority     = 10

  condition {
    host_header {
      values = [var.endpoint_details.domain_url]
    }
  }

  dynamic "action" {
    for_each = var.authenticate_oidc_details != null ? [1] : []

    content {
      type = "authenticate-oidc"

      authenticate_oidc {
        authorization_endpoint     = local.authenticate_oidc_authorization_endpoint
        token_endpoint             = local.authenticate_oidc_token_endpoint
        user_info_endpoint         = local.authenticate_oidc_user_info_endpoint
        issuer                     = local.authenticate_oidc_issuer
        session_cookie_name        = format("TOKEN-OIDC-%s", var.authenticate_oidc_details.client_id)
        scope                      = "openid email"
        on_unauthenticated_request = "authenticate"
        client_id                  = var.authenticate_oidc_details.client_id
        client_secret              = var.authenticate_oidc_details.client_secret
      }
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target[0].arn
  }
}

resource "aws_lb_listener_rule" "events_post_rule" {
  listener_arn = var.endpoint_details.lb_listener_arn
  priority     = 1

  condition {
    path_pattern {
      values = ["/events"]
    }
  }

  condition {
    http_request_method {
      values = ["POST"]
    }
  }

  condition {
    host_header {
      values = [var.endpoint_details.domain_url]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target[0].arn
  }
}
