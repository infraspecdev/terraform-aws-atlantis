<!-- BEGIN_TF_DOCS -->
## Prerequisites

Before using the Terraform configuration, ensure you have the following setup:

- **Application secrets stored in AWS SSM Parameter Store** with the following names and descriptions:
  - `/atlantis/ATLANTIS_GH_TOKEN`: A GitHub personal access token with repo and admin:repo\_hook permissions. Generate this from GitHub Developer settings.
  - `/atlantis/ATLANTIS_GH_WEBHOOK_SECRET`: The secret used to validate GitHub webhooks. Create a random secret string for this.
  - `/atlantis/AWS_ACCESS_KEY_ID`: The AWS Access Key ID for an IAM user with necessary permissions. Obtain this from AWS IAM user security credentials.
  - `/atlantis/AWS_SECRET_ACCESS_KEY`: The AWS Secret Access Key for the same IAM user. Obtain this from AWS IAM user security credentials.
  - `/atlantis/ATLANTIS_GOOGLE_CLIENT_ID`: The Client ID for Google OAuth. Obtain this from Google Cloud Console.
  - `/atlantis/ATLANTIS_GOOGLE_CLIENT_SECRET`: The Client Secret for Google OAuth. Obtain this from Google Cloud Console.

- **Set up OAuth in the Google Cloud Console**:
  - **Authorized JavaScript origins**:
    - Use the value of `ATLANTIS_URL` from your `locals.tf`, defined as:
      ```hcl
      ATLANTIS_URL = "https://${var.atlantis_url}"
      ```
  - **Authorized redirect URIs**:
    - Use the value of `ATLANTIS_GOOGLE_REDIRECT_URI` from your `locals.tf`, defined as:
      ```hcl
      ATLANTIS_GOOGLE_REDIRECT_URI = "https://${var.atlantis_url}/oauth2/idpresponse"
      ```

## Example `tfvars` Configuration

Here’s an example of how you can configure your `tfvars` file:

```hcl
# Required Parameters
public_subnet_ids              = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
private_subnet_ids             = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
vpc_id                         = "vpc-xxxxxxxx"
atlantis_url                   = "example.your-domain.com"
atlantis_gh_user               = "your-github-username"
atlantis_repo_allowlist        = ["repo1", "repo2"]

# Optional Parameters
# thumbprint_list                = ["oidc-thumbprint-1", "oidc-thumbprint-2"]
# atlantis_docker_image          = "<your-custom-docker-image>"
# ecs_cluster_name               = "<your-ecs-cluster-name>"
```

## Usage

To deploy the configuration, follow these steps:

1. **Initialize Terraform**:
   ```sh
   terraform init
   ```

2. **Plan the Deployment**:
   ```sh
   terraform plan
   ```

3. **Apply the Configuration**:
   ```sh
   terraform apply
   ```

4. **Clean Up Resources** (if needed):
   ```sh
   terraform destroy
   ```

   Use this command to remove all resources created by this configuration when they are no longer needed.

**Note**: Be aware that applying this configuration may create resources that could incur charges on your AWS bill.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_gh_user"></a> [atlantis\_gh\_user](#input\_atlantis\_gh\_user) | GitHub username for Atlantis | `string` | n/a | yes |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | GitHub repository allowlist for Atlantis | `string` | n/a | yes |
| <a name="input_atlantis_url"></a> [atlantis\_url](#input\_atlantis\_url) | Full URL for the Atlantis server | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where resources will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authorized_javascript_origin"></a> [authorized\_javascript\_origin](#output\_authorized\_javascript\_origin) | The base URL for your application that is authorized to use JavaScript for OAuth requests. |
| <a name="output_authorized_redirect_uri"></a> [authorized\_redirect\_uri](#output\_authorized\_redirect\_uri) | The redirect URI used by your OAuth provider to return responses to your application. |
| <a name="output_github_webhook_url"></a> [github\_webhook\_url](#output\_github\_webhook\_url) | The URL for GitHub webhook |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the private subnets. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the public subnets. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
<!-- END_TF_DOCS -->
