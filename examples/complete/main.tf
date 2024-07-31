module "atlantis" {
  source                  = "../.."
  public_subnet_ids       = var.public_subnet_ids
  private_subnet_ids      = var.private_subnet_ids
  vpc_id                  = var.vpc_id
  atlantis_gh_user        = var.atlantis_gh_user
  atlantis_repo_allowlist = var.atlantis_repo_allowlist
  atlantis_url            = var.atlantis_url
}
