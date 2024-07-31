resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.sub_domain
  type    = "A"

  alias {
    name                   = module.ecs_deployment.alb_dns_name
    zone_id                = module.ecs_deployment.alb_zone_id
    evaluate_target_health = true
  }
}
