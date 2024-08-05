<!-- BEGIN_TF_DOCS -->
# terraform-aws-atlantis

This Terraform module automates the deployment of the Atlantis server on an ECS cluster with self-managed EC2 instances. It includes the configuration of an Application Load Balancer (ALB) for traffic routing. The module simplifies the process of setting up and managing Atlantis, enabling automated Terraform pull request workflows.

---

### Architectural Diagram

![atlantis](https://github.com/user-attachments/assets/0252b4a9-38e3-4e8d-9212-fcfc091001a4)

---

## Prerequisites

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
| <a name="module_ecs_deployment"></a> [ecs\_deployment](#module\_ecs\_deployment) | infraspecdev/ecs-deployment/aws | 4.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ecs_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_policy_document.ecs_task_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_ssm_parameter.environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_docker_image"></a> [atlantis\_docker\_image](#input\_atlantis\_docker\_image) | The Docker image to use for the Atlantis server | `string` | `"ghcr.io/runatlantis/atlantis:v0.23.1"` | no |
| <a name="input_atlantis_gh_user"></a> [atlantis\_gh\_user](#input\_atlantis\_gh\_user) | The GitHub username used by Atlantis to access repositories | `string` | n/a | yes |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | Comma delimited string containing repos to use atlantis | `string` | n/a | yes |
| <a name="input_atlantis_url"></a> [atlantis\_url](#input\_atlantis\_url) | Full URL for the Atlantis server | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The name of the ECS cluster | `string` | `"default"` | no |
| <a name="input_ecs_launch_type_cpu"></a> [ecs\_launch\_type\_cpu](#input\_ecs\_launch\_type\_cpu) | EC2 instance CPU | `number` | `null` | no |
| <a name="input_ecs_launch_type_memory"></a> [ecs\_launch\_type\_memory](#input\_ecs\_launch\_type\_memory) | EC2 instance memory | `number` | `null` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | (Optional) Number of instances of the task definition to place and keep running. | `number` | `null` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private subnet ids to deploy Atlantis server. | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of Public subnet ids to deploy application load balancers. | `list(string)` | n/a | yes |
| <a name="input_thumbprint_list"></a> [thumbprint\_list](#input\_thumbprint\_list) | The thumbprint of the OIDC provider | `list(string)` | <pre>[<br>  "e252aa6e92432f32cbc1b182056627c239652678"<br>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for creating Atlantis Resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_atlantis_url"></a> [atlantis\_url](#output\_atlantis\_url) | The URL for Atlantis. |
<!-- END_TF_DOCS -->
