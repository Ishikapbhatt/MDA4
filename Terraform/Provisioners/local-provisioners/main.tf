provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-02167eae61967e403"
  instance_type = "t3.micro"
  
  provisioner "local-exec" {
    command = "echo 'Hello from local provisioner'"
  }
}
