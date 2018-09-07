# TODO update to use published source
module "logs" {
  source = "git@github.com:willfarrell/terraform-s3-logs-module"
  name = "tfstate${local.name}"
}

resource "aws_s3_bucket" "main" {
  bucket              = "tfstate${local.name}"
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
    //Security = "SSE:KMS"
    Security = "SSE:AWS"
  }
}

// Causes: Failed to save state: failed to upload state: AccessDenied: Access Denied
//	status code: 403, request id: ***********, host id: *********
//resource "aws_s3_bucket_policy" "main" {
//  bucket = "${aws_s3_bucket.main.id}"
//  policy =<<POLICY
//{
//  "Version": "2012-10-17",
//  "Id": "Terraform Remote State Policy",
//  "Statement": [
//     {
//        "Sid":"DenyIncorrectEncryptionHeader",
//        "Effect":"Deny",
//        "Principal":"*",
//        "Action":"s3:PutObject",
//        "Resource":"arn:aws:s3:::${aws_s3_bucket.main.id}/*",
//        "Condition":{
//           "StringNotEquals":{
//             "s3:x-amz-server-side-encryption": "${local.sse_algorithm}"
//           }
//        }
//     },
//     {
//        "Sid":"DenyUnEncryptedObjectUploads",
//        "Effect":"Deny",
//        "Principal":"*",
//        "Action":"s3:PutObject",
//        "Resource":"arn:aws:s3:::${aws_s3_bucket.main.id}/*",
//        "Condition":{
//           "Null":{
//              "s3:x-amz-server-side-encryption":"true"
//           }
//        }
//     }
//  ]
//}
//POLICY
//}
