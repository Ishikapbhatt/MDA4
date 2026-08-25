provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  
  ami           = "ami-08b7b9fdd7a1edf3d"
  instance_type = "t3.micro"
  # HEREDOC - here document
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y   
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF   
  
  tags = {
    Name = "web-server"
  }
}

output "instance_id" {
  value = aws_instance.web_server.id
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

