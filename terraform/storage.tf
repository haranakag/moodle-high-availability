resource "aws_s3_bucket" "moodle_data" {
  bucket_prefix = "${var.project_name}-data-"
  tags = {
    Name = "${var.project_name}-s3"
  }
}

resource "aws_s3_bucket_ownership_controls" "moodle_data" {
  bucket = aws_s3_bucket.moodle_data.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "moodle_data" {
  depends_on = [aws_s3_bucket_ownership_controls.moodle_data]

  bucket = aws_s3_bucket.moodle_data.id
  acl    = "private"
}
