# -----------------------
# RDS PostgreSQL Database
# -----------------------
resource "aws_db_instance" "novabank_db" {
  identifier = "novabank-db"

  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "novabank"
  username = "novabank_admin"
  password = "ChangeMe123!"

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name        = "NovaBank-DB"
    Environment = "dev"
  }
}
