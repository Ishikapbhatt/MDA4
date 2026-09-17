terraform {
  backend "s3" {
    bucket         = "ishika-terraform-state"
    key            = "eks-modules/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
