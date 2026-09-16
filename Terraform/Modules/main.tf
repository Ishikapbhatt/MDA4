module "vpc" {
  source = "./vpc"

  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr       = var.public_subnet_cidr
  private_subnet_cidr      = var.private_subnet_cidr
  availability_zone_public  = var.availability_zone_public
  availability_zone_private = var.availability_zone_private
  project_name             = var.project_name
  environment              = var.environment
  vpc_tags                 = var.tags
  security_group_name       = var.security_group_name
  security_group_description = var.security_group_description
  security_group_tags      = var.tags
}

module "s3" {
  source = "./s3"

  s3_bucket_name = var.s3_bucket_name
  s3_bucket_tags = var.tags
  project_name   = var.project_name
  environment    = var.environment
}

module "ec2" {
  source = "./ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_id
  security_group_id  = module.vpc.security_group_id
  tags               = var.tags
  project_name       = var.project_name
  environment        = var.environment
}