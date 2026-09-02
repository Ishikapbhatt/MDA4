resource "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name
  tags = merge(
    var.s3_bucket_tags,
    {
      Name = "${var.project_name}-${var.environment}-s3-bucket"
    }
  )
}