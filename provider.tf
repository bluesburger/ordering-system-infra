terraform {
  backend "s3" {
    bucket = "order.system"
    key    = "bluesburguer/infra.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = var.regionDefault

  default_tags {
    tags = var.tags
  }
}