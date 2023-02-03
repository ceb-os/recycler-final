terraform {
   required_version = "= 1.3.6"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.40.0"
      }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #es posible que esto no sea necesario
  access_key = var.access_key
  secret_key = var.secret_key
}





