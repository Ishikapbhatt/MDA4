terraform {
  backend "s3" {
    bucket         = "terraform-state-ishika-2026"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-08b7b9fdd7a1edf3d"
  instance_type = "t2.micro"
}