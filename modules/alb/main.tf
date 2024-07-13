resource "aws_lb" "this" {
  name               = "${var.system_name}-lb-${terraform.workspace}"
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.this.id]
  # subnet-1 , subnet-2
  subnets = var.public_subnet_ids
}

resource "aws_security_group" "this" {
  vpc_id      = var.vpc_id
  name        = "${var.system_name}--${terraform.workspace}"
  description = "Load balancer security firewall"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.system_name}-${terraform.workspace}"
  }
}

resource "aws_lb_listener" "https_listener" {
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "application/json"
      message_body = "Unauthorised"
      status_code  = 401
    }
  }

  protocol          = "HTTPS"
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  ssl_policy        = var.ssl_policy
  certificate_arn   = data.aws_acm_certificate.base_domain_certificate.arn
}

resource "aws_route53_record" "record" {
  for_each = toset(var.endpoints)
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = each.key
  type     = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb_listener" "http_listner" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
