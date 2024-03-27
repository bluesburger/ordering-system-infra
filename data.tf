data "aws_caller_identity" "current" {}

data "aws_vpc" "existing_vpc" {
  tags = {
    Name = "vpc-blues-burger"
  }
}


data "aws_subnet" "existing-subnet-private-1" {
  tags = {
    Name = "subnet-private-blues-burger-1"
  }
}

data "aws_subnet" "existing-subnet-private-2" {
  tags = {
    Name = "subnet-private-blues-burger-2"
  }
}

data "aws_db_instance" "database" {
  db_instance_identifier = "rds-blues-burger"
}

data "aws_security_group" "existing-cluster-security-group" {
  tags = {
    Name = "cluster-security-group"
  }
}

data "aws_security_group" "existing-load-balancer-security-group" {
  tags = {
    Name = "balancers-security-group"
  }
}