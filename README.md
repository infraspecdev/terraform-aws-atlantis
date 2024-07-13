# Terraform Module to setup Atlantis in ECS with self managed EC2 instances

This Terraform module automates the deployment of the Atlantis server on an ECS cluster with self-managed EC2 instances. It includes the configuration of an Application Load Balancer (ALB) for traffic routing. The module simplifies the process of setting up and managing Atlantis, enabling automated Terraform pull request workflows.

## Prerequisites

- Domain with acm certificate attached
- Application secrets stored in AWS SSM Parameter Store with the following names and descriptions:

  - `/atlantis/ATLANTIS_GH_USER`: The GitHub username used by Atlantis. Obtain this from your GitHub account settings.
  - `/atlantis/ATLANTIS_GH_TOKEN`: A GitHub personal access token with repo and admin:repo\_hook permissions. Generate this from GitHub Developer settings.
  - `/atlantis/ATLANTIS_GH_WEBHOOK_SECRET`: The secret used to validate GitHub webhooks. Create a random secret string for this.
  - `/atlantis/AWS_ACCESS_KEY_ID`: The AWS Access Key ID for an IAM user with necessary permissions. Obtain this from AWS IAM user security credentials.
  - `/atlantis/AWS_SECRET_ACCESS_KEY`: The AWS Secret Access Key for the same IAM user. Obtain this from AWS IAM user security credentials.

## Example tfvars configuration

```
public_subnet_ids              = ["subnet-0123456789", "subnet-1234567890"]
system_name                    = "atlantis"
private_subnet_ids             = ["subnet-9876543210", "subnet-6543217890"]
vpc_id                         = "vpc-1234567890"
ecs_cluster_name               = "atlantis"
ecs_service_name               = "atlantis"
ecs_task_definition_family     = "atlantis"
ecs_launch_type_cpu            = 256
ecs_launch_type_memory         = 512
ecs_container_definations_name = "atlantis"
vpc_cidr_block                 = "10.0.0.0/16"
base_domain                    = "base_domain.io"
sub_domain                     = "testatlantis"
launch_template_key_name       = "test-atlantis"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
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
| [aws_ssm_parameter.environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | Comma delimited string containing repos to use atlantis | `string` | `"github.com/Rahul-4480/test-atlantis"` | no |
| <a name="input_base_domain"></a> [base\_domain](#input\_base\_domain) | Your base domain with acm certificate attached to it. | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | (Required) Name of the cluster. | `string` | n/a | yes |
| <a name="input_ecs_container_definations_name"></a> [ecs\_container\_definations\_name](#input\_ecs\_container\_definations\_name) | Name of the ECS container defination. | `string` | n/a | yes |
| <a name="input_ecs_launch_type_cpu"></a> [ecs\_launch\_type\_cpu](#input\_ecs\_launch\_type\_cpu) | EC2 instance CPU | `number` | n/a | yes |
| <a name="input_ecs_launch_type_memory"></a> [ecs\_launch\_type\_memory](#input\_ecs\_launch\_type\_memory) | EC2 instance memory | `number` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | (Required) Name of the service. | `string` | n/a | yes |
| <a name="input_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#input\_ecs\_task\_definition\_family) | (Required) A unique name for your task definition. | `string` | n/a | yes |
| <a name="input_launch_template_key_name"></a> [launch\_template\_key\_name](#input\_launch\_template\_key\_name) | (Optional) The key name to use for the instance. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private subnet ids to deploy Atlantis server. | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of Public subnet ids to deploy application load balancers. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create resources in | `string` | `"ap-south-1"` | no |
| <a name="input_sub_domain"></a> [sub\_domain](#input\_sub\_domain) | Your desired sub domain | `string` | n/a | yes |
| <a name="input_system_name"></a> [system\_name](#input\_system\_name) | Name of the System | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR block for creating security groups. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for creating Atlantis Resources. | `string` | n/a | yes |

## Outputs

No outputs.
