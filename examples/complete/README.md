
## Example `tfvars` Configuration

```hcl
# Required Parameters
public_subnet_ids              = ["subnet-050928489741239", "subnet-98347019238472343"]
private_subnet_ids             = ["subnet-09483509823434", "subnet-57093487509234870"]
vpc_id                         = "vpc-43523452345265253"
base_domain                    = "example.com"
sub_domain                     = "atlantis"
atlantis_gh_user                = "your-github-username"
atlantis_repo_allowlist         = ["repo1", "repo2"]
