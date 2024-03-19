# data "aws_db_instance" "database" {
#   db_instance_identifier = "rds-${var.projectName}"
# }

# data "aws_iam_role" "ecs_task_execution_role" {
# name = "ecsTaskExecutionRole"
# arn = "arn:aws:iam::${var.AWSAccount}:role/ecsTaskExecutionRole"
# }

data "aws_caller_identity" "current" {}

data "aws_vpc" "existing_vpcs" {
  tags = {
    Name = "vpc-terraform"
  }
}


data "aws_subnet" "existing_subnet1" {
  tags = {
    Name = "subnet-terraform-public-1"
  }
}

data "aws_subnet" "existing_subnet2" {
  tags = {
    Name = "subnet-terraform-public-2"
  }
}

data "aws_subnet" "existing_subnet3" {
  tags = {
    Name = "subnet-terraform-public-3"
  }
}

data "aws_db_instance" "database" {
  db_instance_identifier = "rds-${var.projectName}"
}