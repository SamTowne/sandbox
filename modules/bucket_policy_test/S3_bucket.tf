resource "aws_s3_bucket" "regular" {
  bucket = "${var.module_prefix}-regular"
}