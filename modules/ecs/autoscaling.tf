resource "aws_autoscaling_group" "this" {
  desired_capacity    = var.auto_scaling_group_desired_capacity != null ? var.auto_scaling_group_desired_capacity : 1
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
    value               = "${var.service_name}-ec2"
    propagate_at_launch = true
  }
}
