## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.59.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb_listener_rule.default_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.events_post_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.ip_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.ecs_task_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authenticate_oidc_details"></a> [authenticate\_oidc\_details](#input\_authenticate\_oidc\_details) | Contains OIDC authentication details (endpoint, client ID, client secret) for Atlantis server integration. | <pre>object({<br>    oidc_endpoint = string<br>    client_id     = string<br>    client_secret = string<br>  })</pre> | n/a | yes |
| <a name="input_auto_scaling_group_desired_capacity"></a> [auto\_scaling\_group\_desired\_capacity](#input\_auto\_scaling\_group\_desired\_capacity) | (Optional) Number of Amazon EC2 instances that should be running in the group. | `number` | n/a | yes |
| <a name="input_auto_scaling_group_max_size"></a> [auto\_scaling\_group\_max\_size](#input\_auto\_scaling\_group\_max\_size) | (Required) Maximum size of the Auto Scaling Group. | `number` | n/a | yes |
| <a name="input_auto_scaling_group_min_size"></a> [auto\_scaling\_group\_min\_size](#input\_auto\_scaling\_group\_min\_size) | (Required) Minimum size of the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | (Required) ARN value of the default ecs cluster | `string` | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | JSON encoded list of container definition assigned to ecs task | `string` | n/a | yes |
| <a name="input_endpoint_details"></a> [endpoint\_details](#input\_endpoint\_details) | Endpoint details | <pre>object({<br>    lb_listener_arn = string<br>    domain_url      = string<br>  })</pre> | `null` | no |
| <a name="input_launch_template_image_id"></a> [launch\_template\_image\_id](#input\_launch\_template\_image\_id) | (Optional) The AMI from which to launch the instance. | `string` | `"ami-0352888a5fa748216"` | no |
| <a name="input_launch_template_instance_type"></a> [launch\_template\_instance\_type](#input\_launch\_template\_instance\_type) | (Optional) The type of the instance. | `string` | n/a | yes |
| <a name="input_launch_template_key_name"></a> [launch\_template\_key\_name](#input\_launch\_template\_key\_name) | (Optional) The key name to use for the instance. | `string` | n/a | yes |
| <a name="input_launch_template_name_prefix"></a> [launch\_template\_name\_prefix](#input\_launch\_template\_name\_prefix) | Name prefix for the launch template resource. | `string` | `"ecs-"` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | ECS launch type | <pre>object({<br>    type   = string<br>    cpu    = optional(number)<br>    memory = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private subnet ids to deploy containers. | `list(string)` | n/a | yes |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | (Optional) Number of instances of the task definition to place and keep running. | `number` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | (Required) Name of the service. | `string` | `"atlantis"` | no |
| <a name="input_task_definition_family"></a> [task\_definition\_family](#input\_task\_definition\_family) | (Required) A unique name for your task definition. | `string` | `"atlantis"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR block for creating security group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for creating ECS Resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The name of the ECS service |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the ECS task definition |
| <a name="output_endpoint_details"></a> [endpoint\_details](#output\_endpoint\_details) | Details of the ECS service endpoint |
