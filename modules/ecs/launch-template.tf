resource "aws_launch_template" "this" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.launch_template_image_id != null ? var.launch_template_image_id : local.launch_template_image_id
  instance_type = var.launch_template_instance_type != null ? var.launch_template_instance_type : local.launch_template_instance_type
  key_name      = var.launch_template_key_name

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_arn} >> /etc/ecs/ecs.config
EOF
  )

  network_interfaces {
    subnet_id       = var.private_subnet_ids[0]
    security_groups = [aws_security_group.this.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
