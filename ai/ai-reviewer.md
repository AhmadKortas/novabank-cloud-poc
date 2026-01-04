# AI IaC Reviewer – Infrastructure as Code Review Example

## Purpose
This document demonstrates how a Large Language Model (LLM) can be used as an **AI-assisted reviewer** for Infrastructure as Code (IaC).
The goal is to support consultants by automatically flagging common cloud and Terraform issues early in the delivery process.

This is a **conceptual but practical example**, showing how AI would be integrated into a real consulting workflow.

---

## What Problem This Solves
During cloud projects, Terraform code reviews are often:
- Time-consuming
- Repetitive
- Prone to human oversight

An AI reviewer can quickly identify:
- Missing or incomplete resource tags
- Publicly exposed resources
- Missing logging or diagnostics
- Basic security or compliance gaps

The AI does **not replace human judgement**, but acts as a first-pass reviewer.

---

## Context Provided to the LLM

The following Terraform code can be provided to the LLM as review input:

```hcl
resource "aws_instance" "novabank_api" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name        = "NovaBank-API"
    Environment = "dev"
  }
}

resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/novabank/api"
  retention_in_days = 365
}
