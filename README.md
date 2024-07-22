# terraform-aws-atlantis

This Terraform module automates the deployment of the Atlantis server on an ECS cluster with self-managed EC2 instances. It includes the configuration of an Application Load Balancer (ALB) for traffic routing. The module simplifies the process of setting up and managing Atlantis, enabling automated Terraform pull request workflows.

## Prerequisites

- Domain with ACM certificate attached
- Application secrets stored in AWS SSM Parameter Store with the following names and descriptions:
  - `/atlantis/ATLANTIS_GH_TOKEN`: A GitHub personal access token with repo and admin:repo\_hook permissions. Generate this from GitHub Developer settings.
  - `/atlantis/ATLANTIS_GH_WEBHOOK_SECRET`: The secret used to validate GitHub webhooks. Create a random secret string for this.
  - `/atlantis/AWS_ACCESS_KEY_ID`: The AWS Access Key ID for an IAM user with necessary permissions. Obtain this from AWS IAM user security credentials.
  - `/atlantis/AWS_SECRET_ACCESS_KEY`: The AWS Secret Access Key for the same IAM user. Obtain this from AWS IAM user security credentials.
  - `/atlantis/ATLANTIS_GOOGLE_CLIENT_ID`: The Client ID for Google OAuth. Obtain this from Google Cloud Console.
  - `/atlantis/ATLANTIS_GOOGLE_CLIENT_SECRET`: The Client Secret for Google OAuth. Obtain this from Google Cloud Console.

- Set up the following in the Google Cloud Console for the OAuth consent screen:
  - **Authorized JavaScript origins**:
    - Use the value of `ATLANTIS_URL` from your `locals.tf`, which is defined as:
      ```hcl
      ATLANTIS_URL = "https://${local.atlantis_url}"
      ```

  - **Authorized redirect URIs**:
    - Use the value of `ATLANTIS_GOOGLE_REDIRECT_URI` from your `locals.tf`, which is defined as:
      ```hcl
      ATLANTIS_GOOGLE_REDIRECT_URI = "https://${local.atlantis_url}/oauth2/idpresponse"
      ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_ecs_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_ssm_parameter.environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_gh_user"></a> [atlantis\_gh\_user](#input\_atlantis\_gh\_user) | The GitHub username used by Atlantis to access repositories | `string` | n/a | yes |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | Comma delimited string containing repos to use atlantis | `string` | n/a | yes |
| <a name="input_base_domain"></a> [base\_domain](#input\_base\_domain) | Your base domain with acm certificate attached to it. | `string` | n/a | yes |
| <a name="input_container_memory_reservation"></a> [container\_memory\_reservation](#input\_container\_memory\_reservation) | Soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit | `number` | n/a | yes |
| <a name="input_ecs_auto_scaling_group_desired_capacity"></a> [ecs\_auto\_scaling\_group\_desired\_capacity](#input\_ecs\_auto\_scaling\_group\_desired\_capacity) | (Optional) Number of Amazon EC2 instances that should be running in the group. | `number` | `null` | no |
| <a name="input_ecs_auto_scaling_group_max_size"></a> [ecs\_auto\_scaling\_group\_max\_size](#input\_ecs\_auto\_scaling\_group\_max\_size) | (Required) Maximum size of the Auto Scaling Group. | `number` | n/a | yes |
| <a name="input_ecs_auto_scaling_group_min_size"></a> [ecs\_auto\_scaling\_group\_min\_size](#input\_ecs\_auto\_scaling\_group\_min\_size) | (Required) Minimum size of the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_ecs_launch_template_image_id"></a> [ecs\_launch\_template\_image\_id](#input\_ecs\_launch\_template\_image\_id) | (Optional) The AMI from which to launch the instance. | `string` | `null` | no |
| <a name="input_ecs_launch_template_instance_type"></a> [ecs\_launch\_template\_instance\_type](#input\_ecs\_launch\_template\_instance\_type) | (Optional) The type of the instance. | `string` | `null` | no |
| <a name="input_ecs_launch_type_cpu"></a> [ecs\_launch\_type\_cpu](#input\_ecs\_launch\_type\_cpu) | EC2 instance CPU | `number` | `null` | no |
| <a name="input_ecs_launch_type_memory"></a> [ecs\_launch\_type\_memory](#input\_ecs\_launch\_type\_memory) | EC2 instance memory | `number` | `null` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | (Optional) Number of instances of the task definition to place and keep running. | `number` | `null` | no |
| <a name="input_launch_template_key_name"></a> [launch\_template\_key\_name](#input\_launch\_template\_key\_name) | The key name to use for the instance. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private subnet ids to deploy Atlantis server. | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of Public subnet ids to deploy application load balancers. | `list(string)` | n/a | yes |
| <a name="input_sub_domain"></a> [sub\_domain](#input\_sub\_domain) | Your desired sub domain | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for creating Atlantis Resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the ALB |
| <a name="output_authorized_javascript_origin"></a> [authorized\_javascript\_origin](#output\_authorized\_javascript\_origin) | The base URL for your application that is authorized to use JavaScript for OAuth requests. |
| <a name="output_authorized_redirect_uri"></a> [authorized\_redirect\_uri](#output\_authorized\_redirect\_uri) | The redirect URI used by your OAuth provider to return responses to your application. |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The name of the ECS service |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the ECS task definition |
| <a name="output_github_webhook_url"></a> [github\_webhook\_url](#output\_github\_webhook\_url) | The URL for GitHub webhook |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the private subnets. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the public subnets. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
