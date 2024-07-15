## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.58.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.instace_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb_listener_rule.default_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.events_post_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.instance_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.ip_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.ecs_task_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_group_desired_capacity"></a> [auto\_scaling\_group\_desired\_capacity](#input\_auto\_scaling\_group\_desired\_capacity) | (Optional) Number of Amazon EC2 instances that should be running in the group. | `number` | `2` | no |
| <a name="input_auto_scaling_group_max_size"></a> [auto\_scaling\_group\_max\_size](#input\_auto\_scaling\_group\_max\_size) | (Required) Maximum size of the Auto Scaling Group. | `number` | `3` | no |
| <a name="input_auto_scaling_group_min_size"></a> [auto\_scaling\_group\_min\_size](#input\_auto\_scaling\_group\_min\_size) | (Required) Minimum size of the Auto Scaling Group | `number` | `1` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) Name of the cluster. | `string` | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | JSON encoded list of container definition assigned to ecs task | `string` | n/a | yes |
| <a name="input_endpoint_details"></a> [endpoint\_details](#input\_endpoint\_details) | Endpoint details | <pre>object({<br>    lb_listener_arn = string<br>    domain_url      = string<br>  })</pre> | `null` | no |
| <a name="input_launch_template_image_id"></a> [launch\_template\_image\_id](#input\_launch\_template\_image\_id) | (Optional) The AMI from which to launch the instance. | `string` | `"ami-0352888a5fa748216"` | no |
| <a name="input_launch_template_instance_type"></a> [launch\_template\_instance\_type](#input\_launch\_template\_instance\_type) | (Optional) The type of the instance. | `string` | `"t2.micro"` | no |
| <a name="input_launch_template_key_name"></a> [launch\_template\_key\_name](#input\_launch\_template\_key\_name) | (Optional) The key name to use for the instance. | `string` | n/a | yes |
| <a name="input_launch_template_name_prefix"></a> [launch\_template\_name\_prefix](#input\_launch\_template\_name\_prefix) | Name prefix for the launch template resource. | `string` | `"ecs-"` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | ECS launch type | <pre>object({<br>    type   = string<br>    cpu    = number<br>    memory = number<br>  })</pre> | <pre>{<br>  "cpu": null,<br>  "memory": null,<br>  "type": "EC2"<br>}</pre> | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private subnet ids to deploy containers. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create resources. | `string` | `"ap-south-1"` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | (Optional) Number of instances of the task definition to place and keep running. | `number` | `1` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | (Required) Name of the service. | `string` | n/a | yes |
| <a name="input_task_definition_family"></a> [task\_definition\_family](#input\_task\_definition\_family) | (Required) A unique name for your task definition. | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR block for creating security group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for creating ECS Resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | The name of the ECS cluster |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The name of the ECS service |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the ECS task definition |
| <a name="output_endpoint_details"></a> [endpoint\_details](#output\_endpoint\_details) | Details of the ECS service endpoint |
