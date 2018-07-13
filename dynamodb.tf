
resource "aws_dynamodb_table" "main" {
  name = "terraform-state${local.name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
  server_side_encryption {
    enable = true
  }

  tags {
    Name = "Terraform State"
  }
}
