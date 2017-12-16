output "backend_s3_bucket" {
  value = "${aws_s3_bucket.main.id}"
}
output "backend_s3_bucket_logs" {
  value = "${aws_s3_bucket.main_logs.id}"
}
output "backend_s3_dynamodb_table" {
  value = "${aws_dynamodb_table.main.id}"
}
