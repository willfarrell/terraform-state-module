
locals {
  name = "${var.name != "" ? "-${var.name}" : ""}"
}
