module "logs" {
  source = "git@github.com:willfarrell/terraform-s3-logs-module"
  name = "terraform-state${local.name}"
}

resource "aws_s3_bucket" "main" {
  bucket              = "terraform-state${local.name}"
  acl                 = "private"
  acceleration_status = "Enabled"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${module.logs.id}"
    target_prefix = "log/"
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "${local.sse_algorithm}"
      }
    }
  }

  tags {
    Name = "Terraform Remote State"
    Terraform = true
  }
}
