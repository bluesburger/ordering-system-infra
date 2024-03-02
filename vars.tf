variable "projectName" {
  default = "bluesburger"
}

variable "clusterName" {
  default = "BluesBurguer"
}

variable "regionDefault" {
  default = "us-east-1"
}

variable "subnet01" {
  default = "subnet-034b1783e20b0fedc"
}

variable "subnet02" {
  default = "subnet-0a5daf62da50af0c1"
}

variable "subnet03" {
  default = "subnet-0915e0f1539d59019"
}

variable "vpcId" {
  default = "vpc-0ba01d3564fb4ad56"
}

variable "vpcCIDR" {
  default = "172.31.0.0/16"
}

variable "rdsUser" {
  description = "Inserir usuario do banco em secrets"
}

variable "rdsPass" {
  description = "Inserir senha do banco em secrets"
}

variable "AWSAccount" {
  default = "637423186279"
}

variable "databaseEndpoint" {
  default = "rds-bluesburguer.cvuiykqc6ts9.us-east-1.rds.amazonaws.com:5432"
}

variable "tags" {
  type = map(string)
  default = {
    App      = "bluesburguer",
    Ambiente = "Desenvolvimento"
  }
}