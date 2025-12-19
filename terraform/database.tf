resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.private_data[*].id

  tags = {
    Name = "Moodle DB Subnet Group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  db_name                = "moodle"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name = "${var.project_name}-rds"
  }
}
