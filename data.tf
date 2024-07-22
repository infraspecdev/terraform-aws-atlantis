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
