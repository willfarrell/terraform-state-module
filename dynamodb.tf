
resource "aws_dynamodb_table" "main" {
  name = "terraform-state-${var.name}"
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

/*
aws dynamodb create-table \
    --region "${aws_region}" \
    --profile "${aws_profile}" \
    --table-name "${tfstate_dynamodb_table}" \
    --key-schema "AttributeName=LockID,KeyType=HASH" \
    --provisioned-throughput "ReadCapacityUnits=5,WriteCapacityUnits=5" \
    --attribute-definitions "AttributeName=LockID,AttributeType=S AttributeName=Digest,AttributeType=S"
*/
