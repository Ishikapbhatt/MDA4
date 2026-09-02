variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "my-project"
}

variable "environment" {
  description = "The environment to deploy resources"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.10.0/24"
}

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "us-west-2a"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.20.0/24"
}

variable "availability_zone_private" {
  description = "The availability zone for the private subnet"
  type        = string
  default     = "us-west-2b"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "key_name" {
  description = "The name of the key pair for the EC2 instance"
  type        = string
  default     = "my-key-pair"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "enable_public_subnet" {
  description = "Whether to create a public subnet"
  type        = bool
  default     = true
}

variable "enable_private_subnet" {
  description = "Whether to create a private subnet"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway"
  type        = bool
  default     = true
}

variable "enable_internet_gateway" {
  description = "Whether to create an internet gateway"
  type        = bool
  default     = true
}

variable "enable_security_group" {
  description = "Whether to create a security group"
  type        = bool
  default     = true
}

variable "enable_route_table" {
  description = "Whether to create a route table"
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-s3-bucket"
}

variable "s3_bucket_versioning" {
  description = "Whether to enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
  default     = "security_group_name"
}

variable "security_group_description" {
  description = "Security group description"
  type        = string
  default     = "security_group_description"
}

variable "security_group_rules" {
  description = "Security group rules"
  type        = list(map(string))
  default     = []
}

variable "security_group_tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
  default     = {}
}
