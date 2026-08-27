provider "aws" {
  region = "us-west-2"
}

resource "tls_private_key" "terraform_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = tls_private_key.terraform_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.terraform_key.private_key_pem
  filename = "${path.module}/terraform-key.pem"
  file_permission = "0400"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-02167eae61967e403"
  instance_type = "t3.micro"
  key_name      = "terraform-key"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "time_sleep" "wait_for_instance" {
  depends_on      = [aws_instance.web]
  create_duration = "60s"
}

resource "null_resource" "wait_for_ssh" {
  depends_on = [time_sleep.wait_for_instance]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.web.public_ip
    private_key = tls_private_key.terraform_key.private_key_pem
    agent       = false
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH is ready'"
    ]
  }
}

resource "null_resource" "install_nginx" {
  depends_on = [null_resource.wait_for_ssh]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.web.public_ip
    private_key = tls_private_key.terraform_key.private_key_pem
    agent       = false
    timeout     = "5m"
  }
  
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }
}