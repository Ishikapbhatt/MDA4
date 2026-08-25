provider "aws" {
    region = "us-west-2"
}

# vpc resource

resource "aws_vpc" "main" {
    cidr_block = "192.168.1.0/24"
    tags = {
        Name = "vpc-1"
    }
}

# SUBNET RESOURCE

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.1.0/25"
    availability_zone = "us-west-2a"
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.1.128/25"
    availability_zone = "us-west-2b"
    tags = {
        Name = "private-subnet"
    }
}

# INTERNET GATEWAY RESOURCE

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "igw"
    }
}

# ROUTE TABLE RESOURCE

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-route-table"
    }
}

# ROUTE TABLE ASSOCIATION RESOURCE

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

# NAT

resource "aws_eip" "nat" {
    domain = "vpc"
    tags = {
        Name = "nat-eip"
    }
}

# NAT GATEWAY RESOURCE

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public.id
    tags = {
        Name = "nat-gateway"
    }
}

# ROUTE TABLE FOR PRIVATE SUBNET

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "private-route-table"
    }
}

# ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
}


# SECURITY GROUP RESOURCE

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.main.id
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "sg-1"
    }
}

# INSTANCE RESOURCE

resource "aws_instance" "web" {
    ami = "ami-08b7b9fdd7a1edf3d"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "web-server-public"
    }
}

resource "aws_instance" "web_private" {
    ami = "ami-08b7b9fdd7a1edf3d"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "web-server-private"
    }
}

output "public_instance_id" {
    value = aws_instance.web.id
}

output "private_instance_id" {
    value = aws_instance.web_private.id
}

output "public_instance_public_ip" {
    value = aws_instance.web.public_ip
}

output "private_instance_private_ip" {
    value = aws_instance.web_private.private_ip
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnet_public_id" {
    value = aws_subnet.public.id
}

output "subnet_private_id" {
    value = aws_subnet.private.id
}

