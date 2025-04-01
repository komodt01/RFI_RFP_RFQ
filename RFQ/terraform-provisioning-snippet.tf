# Example Terraform Snippet – Security Architect Reference
# Purpose: Provision a secure Ubuntu VM in AWS with basic tags, logging, and SSH restrictions

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "secure_vm" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
  key_name      = "example-key"
  subnet_id     = "subnet-123456"
  vpc_security_group_ids = ["sg-123456"]

  tags = {
    Name        = "secure-vm"
    Environment = "prod"
    Owner       = "security-arch"
  }

  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted = true
    volume_type = "gp3"
  }

  monitoring = true
}

resource "aws_cloudwatch_log_group" "vm_logs" {
  name              = "/ec2/secure_vm_logs"
  retention_in_days = 30
}
