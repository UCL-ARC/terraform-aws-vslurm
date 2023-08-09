# This is the main entry point for your Terraform code.

# Create random identifier for demo purposes.
resource "random_id" "this" {
  byte_length = 8
}

locals {
  my_output = "${var.prefix}-${random_id.this.id}"
}