# terraform-state-module
Terraform module: Set up state backend using S3 &amp; DynamoDB

## Use
`global/init/main.tf`:
```hcl-terraform
variable "aws_profile" {
  default = "default"
}

provider "aws" {
  region  = "us-east-1"
  profile = "${var.aws_profile}"
}

module "state" {
  source = "git@github.com/willfarrell/terraform-state-module"
}

output "backend_s3_bucket" {
  value = "${module.state.s3_bucket_id}"
}
output "backend_s3_bucket_logs" {
  value = "${module.state.s3_bucket_logs_id}"
}
output "backend_s3_dynamodb_table" {
  value = "${module.state.dynamodb_table_id}"
}

```

### Remote State
```hcl-terraform
terraform {
  backend "s3" {
    bucket         = "terraform-state-NAME"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    profile        = "tesera"
    dynamodb_table = "terraform-state-NAME"
    kms_key_id     = "arn:aws:kms:us-east-1:<account_id>:key/<key_id>"
  }
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

