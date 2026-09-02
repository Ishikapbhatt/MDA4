provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  count = 3
  ami           = "ami-02167eae61967e403"
  instance_type = "t3.micro"
}
