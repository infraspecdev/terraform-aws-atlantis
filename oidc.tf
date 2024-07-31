resource "aws_iam_openid_connect_provider" "google" {
  client_id_list  = [data.aws_ssm_parameter.environment["ATLANTIS_GOOGLE_CLIENT_ID"].value]
  thumbprint_list = local.thumbprint_list
  url             = local.google_oidc_endpoint
}
