terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1" # EU region (Ireland)
}

# -----------------------
# EC2 Instance (API)
# -----------------------
resource "aws_instance" "novabank_api" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (example)
  instance_type = "t3.micro"              # low cost

  tags = {
    Name        = "NovaBank-API"
    Environment = "dev"
  }
}

# -----------------------
# CloudWatch Log Group
# -----------------------
resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/novabank/api"
  retention_in_days = 365
}