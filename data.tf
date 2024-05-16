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
    Name = "vpc-blues-burger"
  }
}

//referencia o SG criado no repositorio de database
data "terraform_remote_state" "other_repo" {
  backend = "s3"
  config = {
    bucket = "ordering-system-prod"
    key    = "bluesburguer/database.tfstate"
    region = "us-east-1"
  }
}

data "aws_subnet" "existing_subnet1" {
  tags = {
    Name = "subnet-public-blues-burger-1"
  }
}

data "aws_subnet" "existing_subnet2" {
  tags = {
    Name = "subnet-public-blues-burger-2"
  }
}

data "aws_subnet" "existing_subnet3" {
  tags = {
    Name = "subnet-private-blues-burger-1"
  }
}

data "aws_subnet" "existing_subnet4" {
  tags = {
    Name = "subnet-private-blues-burger-2"
  }
}

data "aws_db_instance" "database" {
  db_instance_identifier = var.project_name_order-rds
}

data "aws_security_group" "sg-rds-order" {
  tags = {
    Name = "rds-blues-burger-order-security-group"
  }
}
