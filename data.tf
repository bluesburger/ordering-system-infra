# data "aws_db_instance" "database" {
#   db_instance_identifier = "rds-${var.projectName}"
# }

# data "aws_iam_role" "ecs_task_execution_role" {
# name = "ecsTaskExecutionRole"
# arn = "arn:aws:iam::${var.AWSAccount}:role/ecsTaskExecutionRole"
# }

data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

data "aws_vpc" "existing_vpcs" {
  tags = {
    Name = "vpc-blues-burger"
  }
}

//referencia o SG criado no repositorio de database
data "terraform_remote_state" "other_repo" {
  backend = "s3"
  config = {
    bucket = "bb-ordering-system-production"
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

data "aws_db_instance" "database_menu" {
  db_instance_identifier = var.project_name_menu-rds
}

data "aws_vpc_endpoint" "vpc_endpoint" {
  service_name = "com.amazonaws.${var.regionDefault}.execute-api"
}

data "aws_subnet" "cluster-vpc-subnet-private-1" {
  tags = {
    Name = "subnet-private-blues-burger-1"
  }
}

data "aws_subnet" "cluster-vpc-subnet-private-2" {
  tags = {
    Name = "subnet-private-blues-burger-2"
  }
}

data "aws_security_group" "public_subnet_sg" {
  name = "balancers-security-group"
}