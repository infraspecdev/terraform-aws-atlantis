data "aws_ssm_parameter" "environment" {
  for_each = toset(local.secret_variables)
  name     = "/atlantis/${each.key}"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_ecs_cluster" "default" {
  cluster_name = "default"
}

data "aws_iam_policy_document" "ecs_task_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_acm_certificate" "base_domain_certificate" {
  domain      = var.base_domain
  statuses    = ["ISSUED"]
  most_recent = false
}

data "aws_route53_zone" "zone" {
  name = var.base_domain
}
