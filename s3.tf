resource "aws_s3_bucket" "main-logs" {
  bucket              = "terraform-state${local.name}-logs"
  acl                 = "log-delivery-write"
  acceleration_status = "Enabled"

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix  = "log/"
    tags {
      "rule"      = "log"
      "autoclean" = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  tags {
    Name = "Terraform State Logging"
    Terraform = true
  }
}

resource "aws_s3_bucket" "main" {
  bucket              = "terraform-state${local.name}"
  acl                 = "private"
  acceleration_status = "Enabled"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.main-logs.id}"
    target_prefix = "log/"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "Terraform State"
    Terraform = true
  }
}
