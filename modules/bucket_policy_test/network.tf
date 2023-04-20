resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type   = "Interface"
}