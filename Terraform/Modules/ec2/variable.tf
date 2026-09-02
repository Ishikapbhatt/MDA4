variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "instance_type"
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami_id"
}

variable "key_name" {
  description = "The name of the key pair for the EC2 instance"
  type        = string
  default     = "key_name"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "project_name"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "environment"
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc_id"
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet_id"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
  default     = "security_group_id"
}

