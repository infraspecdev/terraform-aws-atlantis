resource "aws_iam_role" "instance_role" {
  name               = "${local.iam_instance_role_name_prefix}-${random_pet.name.id}"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.instance_role.name
  policy_arn = local.iam_role_policy_arn
}

resource "aws_iam_role" "task_role" {
  name               = "ecs-task-${var.task_definition_family}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_policy.json

  inline_policy {
    name = "ecs-task-permissions"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ecr:*",
            "logs:*",
            "ssm:*",
            "kms:Decrypt",
            "secretsmanager:GetSecretValue",
            "sts:AssumeRoleWithWebIdentity"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}
