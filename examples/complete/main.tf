module "atlantis" {
  source                          = "../.."
  public_subnet_ids               = var.public_subnet_ids
  private_subnet_ids              = var.private_subnet_ids
  vpc_id                          = var.vpc_id
  atlantis_gh_user                = var.atlantis_gh_user
  atlantis_repo_allowlist         = var.atlantis_repo_allowlist
  container_memory_reservation    = var.container_memory_reservation
  base_domain                     = var.base_domain
  sub_domain                      = var.sub_domain
  launch_template_key_name        = var.launch_template_key_name
  ecs_auto_scaling_group_min_size = var.ecs_auto_scaling_group_min_size
  ecs_auto_scaling_group_max_size = var.ecs_auto_scaling_group_max_size
}
