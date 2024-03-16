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

variable "tags" {
  type = map(string)
  default = {
    App      = "bluesburguer",
    Ambiente = "Desenvolvimento"
  }
}

# Define a variável com a região da AWS
variable "aws_region" {
  default = "us-east-1"
}
