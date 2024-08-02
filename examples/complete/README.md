<!-- BEGIN_TF_DOCS -->

## Example `tfvars` Configuration

```hcl
# Required Parameters
public_subnet_ids              = ["subnet-050928489741239", "subnet-98347019238472343"]
private_subnet_ids             = ["subnet-09483509823434", "subnet-57093487509234870"]
vpc_id                         = "vpc-43523452345265253"
atlantis_url                   = "example.your-domain.com"
atlantis_gh_user               = "your-github-username"
atlantis_repo_allowlist        = ["repo1", "repo2"]

# Optional Parameters
thumbprint_list                = ["oidc-thumbprint-1", "oidc-thumbprint-2"]
atlantis_docker_image =        = "<your-custom-docker-image>"
```

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
| <a name="input_atlantis_docker_image"></a> [atlantis\_docker\_image](#input\_atlantis\_docker\_image) | The Docker image to use for the Atlantis server | `string` | `"ghcr.io/runatlantis/atlantis:v0.23.1"` | no |
| <a name="input_atlantis_gh_user"></a> [atlantis\_gh\_user](#input\_atlantis\_gh\_user) | GitHub username for Atlantis | `string` | n/a | yes |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | GitHub repository allowlist for Atlantis | `string` | n/a | yes |
| <a name="input_atlantis_url"></a> [atlantis\_url](#input\_atlantis\_url) | Full URL for the Atlantis server | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_thumbprint_list"></a> [thumbprint\_list](#input\_thumbprint\_list) | List of thumbprints for the OIDC provider | `list(string)` | <pre>[<br>  "e252aa6e92432f32cbc1b182056627c239652678"<br>]</pre> | no |
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