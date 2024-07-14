module "network" {
  source             = "../../modules/network"
  region             = var.region
  availability_zones = var.availability_zones
}

module "alb" {
  source            = "../../modules/alb"
  base_domain       = var.base_domain
  system_name       = var.system_name
  endpoints         = [var.sub_domain]
  public_subnet_ids = module.network.public_subnet_ids
  vpc_id            = module.network.vpc_id
}

module "ecs" {
  source                   = "../../modules/ecs"
  cluster_name             = var.ecs_cluster_name
  service_name             = var.ecs_service_name
  task_definition_family   = var.ecs_task_definition_family
  launch_template_key_name = var.launch_template_key_name

  launch_type = {
    type   = "EC2"
    cpu    = var.ecs_launch_type_cpu
    memory = var.ecs_launch_type_memory
  }

  container_definitions = jsonencode([{
    name           = var.ecs_container_definations_name
    image          = local.ecs_container_definations_image
    container_port = 4141
    environment    = local.env_variables
    secrets        = local.secrets
    command        = ["server"]
  }])
  vpc_id             = module.network.vpc_id
  vpc_cidr_block     = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids

  endpoint_details = {
    lb_listener_arn = module.alb.alb_listener_arn
    domain_url      = local.atlantis_url
  }
}
