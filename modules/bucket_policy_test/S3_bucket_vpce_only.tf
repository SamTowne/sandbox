resource "aws_s3_bucket" "with-policy" {
  bucket = "${var.module_prefix}-with-policy"
}

resource "aws_s3_bucket_policy" "restrict_to_vpce" {
# This adds a deny statement to the bucket to only allow
# operations that source from the specified VPC Endpoint
  bucket = aws_s3_bucket.with-policy.id
  policy = <<EOT
  {
  "Version": "2012-10-17",
  "Id": "Access-to-bucket-using-specific-endpoint",
  "Statement": [
    {
      "Sid": "Access-to-specific-VPCE-only",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": ["${aws_s3_bucket.with-policy.arn}",
                   "${aws_s3_bucket.with-policy.arn}/*"],
      "Condition": {
        "StringNotEquals": {
          "aws:sourceVpce": "${aws_vpc_endpoint.s3.id}"
          }
        }
      }
    ]
  }
  EOT
}