module "bucket_policy_test" {
  source        = "./modules/bucket_policy_test"
  module_prefix = "test-bucket-${data.aws_caller_identity.current.id}"
}