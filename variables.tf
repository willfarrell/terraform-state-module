variable "name" {
  type = "string"
  description = "name to be used. `terraform-state-{name}`"
}
variable "aws_region" {
  type = "string"
  default = "us-east-1"
}
variable "aws_profile" {
  type = "string"
  default = "default"
  description = "AWS Profile to use from `~/.aws/credentials`"
}
