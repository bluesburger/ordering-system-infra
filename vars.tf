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
  default     = "root"
}

variable "rdsPass" {
  description = "Inserir senha do banco em secrets"
  default     = "Root2024"
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

variable "project_name_order" {
  description = "Nome do projeto. Por exemplo, 'bluesburguer'."
  default     = "blues-burger-order"
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
