resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "random_pet" "name" {
  length    = 1
  separator = "-"
}

resource "aws_iam_role" "instace_role" {
  name               = "${local.iam_instance_role_name_prefix}-${random_pet.name.id}"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.instace_role.name
  policy_arn = local.iam_role_policy_arn
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.iam_instance_profile_name_prefix}-${random_pet.name.id}"
  role = aws_iam_role.instace_role.name
}

resource "aws_launch_template" "this" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  key_name      = var.launch_template_key_name

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.this.name} >> /etc/ecs/ecs.config
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.private_subnet_ids[0]
    security_groups             = [aws_security_group.this.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity    = var.auto_scaling_group_desired_capacity
  max_size            = var.auto_scaling_group_max_size
  min_size            = var.auto_scaling_group_min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns     = [aws_lb_target_group.instance_target[0].arn]
  protect_from_scale_in = true

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-ec2"
    propagate_at_launch = true
  }
}

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.name
  launch_type     = var.launch_type.type
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.service_desired_count

  dynamic "load_balancer" {
    for_each = var.endpoint_details != null ? [1] : []

    content {
      container_name   = local.main_container_name
      container_port   = local.main_container_port
      target_group_arn = aws_lb_target_group.ip_target[0].arn
    }
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.this.id]
    assign_public_ip = false
  }

  depends_on = [
    aws_lb_listener_rule.events_post_rule,
    aws_lb_listener_rule.default_rule,
  ]
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_definition_family
  network_mode             = local.task_definition_network_mode
  requires_compatibilities = [var.launch_type.type]
  execution_role_arn       = aws_iam_role.task_role.arn
  container_definitions    = local.container_definitions
  cpu                      = var.launch_type.cpu
  memory                   = var.launch_type.memory
}

resource "aws_iam_role" "task_role" {
  name               = "ecs-task-${var.task_definition_family}-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_policy.json

  inline_policy {
    name = "ecs-task-permissions"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ecr:*",
            "logs:*",
            "ssm:*",
            "kms:Decrypt",
            "secretsmanager:GetSecretValue"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/${var.cluster_name}/${var.service_name}"
  retention_in_days = 14
}

resource "aws_security_group" "this" {
  name        = "${var.service_name}-ecs-sg"
  description = "${var.service_name} ecs security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.main_container_port
    to_port     = local.main_container_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-ecs-sg"
  }
}

resource "aws_lb_target_group" "instance_target" {
  count       = var.endpoint_details != null ? 1 : 0
  name        = format("%s-%s-instance", var.service_name, terraform.workspace)
  port        = local.main_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = local.alb_instance_target_type

  health_check {
    protocol            = "HTTP"
    interval            = 10
    unhealthy_threshold = 6
    matcher             = "200,301-399"
  }
}

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

resource "aws_lb_listener_rule" "events_post_rule" {
  listener_arn = var.endpoint_details.lb_listener_arn
  priority     = 10

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

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target[0].arn
  }
}

resource "aws_lb_listener_rule" "default_rule" {
  listener_arn = var.endpoint_details.lb_listener_arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}
