# Quick setup:
#  1. Replace all instances of st-sandbox with the name of the project
#  2. Replace all instances of 272773485930 with the AWS Account ID in use
#  3. Replace all instances of us-west-2 with the AWS region to deploy to

#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source         = "./modules/bootstrap"
  project_prefix = "st-sandbox-272773485930"
}

############################
### Terraform S3 Backend ###
############################
# This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
terraform {
    backend "s3" {
      bucket         = "st-sandbox-272773485930-terraform-tfstate"
      key            = "terraform.tfstate"
      region         = "us-west-2"
      dynamodb_table = "st-sandbox-272773485930-dynamodb-terraform-locking"
      encrypt        = true
    }
}

#################
### Providers ###
#################

# Credentials are exported or retrieve from an external store like Hashicorp Vault

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Terraform = "true"
      Project   = "st-sandbox"
    }
  }
}