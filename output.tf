output "s3_bucket_id" {
  value = "${aws_s3_bucket.main.id}"
}
output "s3_bucket_logs_id" {
  value = "${module.logs.id}"
}
output "dynamodb_table_id" {
  value = "${aws_dynamodb_table.main.id}"
}

/*
output "kms_arn" {
  value = "${aws_kms_key.main.arn}"
}
*/
