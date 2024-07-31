module "atlantis" {
  source                  = "../.."
  public_subnet_ids       = var.public_subnet_ids
  private_subnet_ids      = var.private_subnet_ids
  vpc_id                  = var.vpc_id
  atlantis_gh_user        = var.atlantis_gh_user
  atlantis_repo_allowlist = var.atlantis_repo_allowlist
  base_domain             = var.base_domain
  sub_domain              = var.sub_domain
}
