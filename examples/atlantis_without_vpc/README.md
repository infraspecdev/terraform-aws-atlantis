# Terraform Module to setup Atlantis in ECS with self managed EC2 instances

This Terraform module automates the deployment of the Atlantis server on an ECS cluster with self-managed EC2 instances. It includes the configuration of an Application Load Balancer (ALB) for traffic routing. The module simplifies the process of setting up and managing Atlantis, enabling automated Terraform pull request workflows.

## Prerequisites

- Domain with acm certificate attached
- Application secrets stored in AWS SSM Parameter Store with the following names and descriptions:

  - `/atlantis/ATLANTIS_GH_USER`: The GitHub username used by Atlantis. Obtain this from your GitHub account settings.
  - `/atlantis/ATLANTIS_GH_TOKEN`: A GitHub personal access token with repo and admin:repo_hook permissions. Generate this from GitHub Developer settings.
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
