terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "ordering-system-bb-dev"
    key    = "infra-cluster-bluesburguer/infra.tfstate"
    region = var.region_default
  }
}

provider "aws" {
  region = var.region_default
}