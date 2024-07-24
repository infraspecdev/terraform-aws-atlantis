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
