variable "projectName" {
  default = "bluesburguer"
}

variable "clusterName" {
  default = "BluesBurguer"
}

variable "regionDefault" {
  default = "us-east-1"
}

variable "vpcCIDR" {
  default = "172.31.0.0/20"
}

variable "rdsUser" {
  description = "Inserir usuario do banco em secrets"
  type        = string
  sensitive   = true
}

variable "rdsPass" {
  description = "Inserir senha do banco em secrets"
  type        = string
  sensitive   = true
}

variable "project_name_dynamo" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "payment"
  type        = string
}

variable "project_name_menu" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "blues-burger-menu"
  type        = string
}

variable "project_name_menu-rds" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "rds-dbmenu"
  type        = string
}

variable "project_name_stock-rds" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "rds-dbstock"
  type        = string
}

variable "project_name_order" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "blues-burger-order"
  type        = string
}

variable "project_name_order-rds" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "rds-dborder"
  type        = string
}

variable "project_name_production" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "blues-burger-production"
  type        = string
}

variable "project_name_stock" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "blues-burger-stock"
  type        = string
}

# variable "databaseEndpoint" {
#   default = "rds-bluesburguer.cvuiykqc6ts9.us-east-1.rds.amazonaws.com:5432"
# }

variable "tags" {
  type = map(string)
  default = {
    App      = "bluesburguer",
    Ambiente = "Desenvolvimento"
  }
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  default = "sua_access_key"
}

variable "aws_secret_key" {
  default = "sua_secret_key"
}

variable "domain_name" {
  description = "Inserir aws secret key"
  type        = string
  default     = "bluesburguer.terraform.com"
}

variable "github_repo_url" {
  default = "https://github.com/bluesburger/orderingsystem-production"
}


locals {
  tags = {
    created_by = "terraform"
  }

  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}