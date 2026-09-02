variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "region"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "vpc_cidr"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "vpc_name"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "public_subnet_cidr"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "private_subnet_cidr"
}

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "availability_zone_public"
}

variable "availability_zone_private" {
  description = "The availability zone for the private subnet"
  type        = string
  default     = "availability_zone_private"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project_name"
}

variable "environment" {
  description = "The environment to deploy resources"
  type        = string
  default     = "environment"
}

variable "vpc_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}
}

variable "enable_internet_gateway" {
  description = "Enable internet gateway"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
  default     = true
}

variable "route_table_propagation" {
  description = "Enable route table propagation"
  type        = bool
  default     = true
}

variable "route_table_association" {
  description = "Enable route table association"
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

