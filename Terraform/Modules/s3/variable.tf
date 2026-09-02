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

variable "s3_bucket_tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}