resource "random_pet" "name" {
  length    = 1
  separator = "-"
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.iam_instance_profile_name_prefix}-${random_pet.name.id}"
  role = aws_iam_role.instance_role.name
}
