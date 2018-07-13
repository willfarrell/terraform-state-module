# terraform-state-module
Terraform module: Set up state backend using S3 &amp; DynamoDB

## Use
`global/init/main.tf`:
```hcl-terraform
variable "name" {
  default = "project-name"
}
variable "aws_region" {
  default = "ca-central-1"
}
variable "aws_profile" {
  default = "default"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

module "state" {
  source = "github.com/willfarrell/terraform-state-module"
  version = "v0.1.0"
}

output "backend_s3_bucket" {
  value = "${module.state.backend_s3_bucket}"
}
output "backend_s3_bucket_logs" {
  value = "${module.state.backend_s3_bucket_logs}"
}
output "backend_s3_dynamodb_table" {
  value = "${module.state.backend_s3_dynamodb_table}"
}

```

## Inputs
- **name:** Makes name unique terraform-state-${name} [Optional]

Ensure `.gitignore` saves these files.
```
# Compiled files
*.tfstate
*.tfstate.backup
!global/init/terraform.tfstate
!global/init/terraform.tfstate.backup

# Module directory
.terraform/
```

