provider "aws" {
  region = "us-west-2"
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "tom-820"
  versioning {
    enabled = true
  }

}

# S3 Replica Bucket
resource "aws_s3_bucket" "my_replica_bucket" {
  bucket = "tom-820-replica"
  versioning {
    enabled = true
  }
}
  

# IAM Role for S3 Replication
resource "aws_iam_role" "replication" {
  name = "s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

# S3 Bucket Replication Configuration
resource "aws_s3_bucket_replication_configuration" "my_bucket_replication" {
  bucket = aws_s3_bucket.my_bucket.id
  role   = aws_iam_role.replication.arn
  rule {
    id       = "replication-rule"
    status   = "Enabled"
    priority = 1
    filter {
      prefix = ""
    }
    destination {
      bucket        = aws_s3_bucket.my_replica_bucket.arn
      storage_class = "STANDARD"
    }
    delete_marker_replication {
      status = "Enabled"
    }
  }
}



