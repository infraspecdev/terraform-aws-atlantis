
## Example `tfvars` Configuration

```hcl
# Required Parameters
public_subnet_ids              = ["subnet-050928489741239", "subnet-98347019238472343"]
private_subnet_ids             = ["subnet-09483509823434", "subnet-57093487509234870"]
vpc_id                         = "vpc-43523452345265253"
base_domain                    = "example.com"
sub_domain                     = "atlantis"
launch_template_key_name       = "atlantis-key"
container_memory_reservation   = 100
ecs_auto_scaling_group_min_size = 1
ecs_auto_scaling_group_max_size = 3

# Optional parameters
ecs_launch_type_cpu            = 256
ecs_launch_type_memory         = 512
ecs_service_desired_count      = 2
ecs_launch_template_instance_type = "t2.micro"
ecs_launch_template_image_id   = "ami-9587934875394875"
ecs_auto_scaling_group_desired_capacity = 1
```

## Notes on Optional Variables

- `ecs_launch_type_cpu` (Optional): Default value will be provided by AWS if not specified.
- `ecs_launch_type_memory` (Optional): Default value will be provided by AWS if not specified.
- `ecs_service_desired_count` (Optional): Default value will be used if not specified.
- `ecs_launch_template_instance_type` (Optional): Default value will be `t2.micro` if not specified.
- `ecs_launch_template_image_id` (Optional): Default ECS optimized Amazon Linux image ID will be used if not specified. If you want to use a specific ECS optimized image ID, you can provide it here.
- `ecs_auto_scaling_group_desired_capacity` (Optional): Default value will be `1` if not specified.
