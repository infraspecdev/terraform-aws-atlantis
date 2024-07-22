module "alb" {
  source            = "./modules/alb"
  base_domain       = var.base_domain
  system_name       = local.alb_system_name
  endpoints         = [var.sub_domain]
  public_subnet_ids = var.public_subnet_ids
  vpc_id            = var.vpc_id
}

module "ecs" {
  source                   = "./modules/ecs"
  cluster_arn              = data.aws_ecs_cluster.default.arn
  launch_template_key_name = var.launch_template_key_name

  launch_type = {
    type   = local.launch_type
    cpu    = try(var.ecs_launch_type_cpu, null)
    memory = try(var.ecs_launch_type_memory, null)
  }

  service_desired_count               = try(var.ecs_service_desired_count, null)
  launch_template_instance_type       = try(var.ecs_launch_template_instance_type, null)
  launch_template_image_id            = try(var.ecs_launch_template_image_id, null)
  auto_scaling_group_desired_capacity = try(var.ecs_auto_scaling_group_desired_capacity, null)
  auto_scaling_group_min_size         = var.ecs_auto_scaling_group_min_size
  auto_scaling_group_max_size         = var.ecs_auto_scaling_group_max_size

  container_definitions = jsonencode([{
    name              = local.ecs_container_definations_name
    image             = local.ecs_container_definations_image
    container_port    = local.container_port
    environment       = local.env_variables
    secrets           = local.secrets
    command           = ["server"]
    memoryReservation = var.container_memory_reservation
  }])

  vpc_id             = var.vpc_id
  vpc_cidr_block     = data.aws_vpc.selected.cidr_block
  private_subnet_ids = var.private_subnet_ids

  endpoint_details = {
    lb_listener_arn = module.alb.alb_listener_arn
    domain_url      = local.atlantis_url
  }

  authenticate_oidc_details = {
    oidc_endpoint = local.google_oidc_endpoint
    client_id     = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value
    client_secret = data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_SECRET"].value
  }
}

resource "aws_iam_openid_connect_provider" "google" {
  client_id_list  = [data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value]
  thumbprint_list = local.thumbprint_list
  url             = local.google_oidc_endpoint
}
