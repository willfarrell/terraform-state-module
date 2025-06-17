resource "aws_s3_bucket" "main" {
  bucket = "terraform-state${local.name}"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name      = "Terraform Remote State"
    Terraform = true
    #Security = "SSE:KMS"
    Security = "SSE:AWS"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm      = var.sse_algorithm
      #kms_master_key_id = aws_kms_key.integrations.arn
    }
  }
}


# resource "aws_s3_bucket_lifecycle_configuration" "main" {
#   bucket = aws_s3_bucket.main.id
# 
# }

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

