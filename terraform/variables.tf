variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name to be used for tagging resources"
  type        = string
  default     = "moodle-ha"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "Password for the RDS master user"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Username for the RDS master user"
  type        = string
  default     = "admin"
}
