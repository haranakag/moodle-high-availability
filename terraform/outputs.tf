output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = aws_db_instance.default.endpoint
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.moodle_data.id
}
