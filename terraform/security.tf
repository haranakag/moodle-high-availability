# Security Groups

# ALB Security Group
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# App Server Security Group
resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Allow HTTP from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}

# Database Security Group
resource "aws_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "Allow MySQL/Aurora access from App Servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from App SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  tags = {
    Name = "${var.project_name}-db-sg"
  }
}

# WAF (Web Application Firewall)
resource "aws_wafv2_web_acl" "main" {
  name        = "${var.project_name}-waf"
  description = "Moodle WAF ACL"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "MoodleWAF"
    sampled_requests_enabled   = true
  }
  
  # Add rules as needed (e.g., SQLi, XSS protection managed rules)
}
