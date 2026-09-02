module "vpc" {
  source = "./vpc"
}

module "s3" {
  source = "./s3"
}

module "ec2" {
  source = "./ec2"
}

