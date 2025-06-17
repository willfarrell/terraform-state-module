variable "name" {
  type        = string
  description = "name to be used. `tfstate-{name}`"
  default     = ""
}

variable "sse_algorithm" {
  type        = string
  description = ""
  default     = "AES256" # "aws:kms:dsse"
}