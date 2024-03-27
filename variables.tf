variable "region_default" {
  description = "Região padrão da AWS"
  default     = "us-east-1"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  default     = "bluesburguer"
  type        = string
}

variable "database_name" {
  description = "Nome do projeto"
  default     = "rds-blues-burger"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster ECS"
  default     = "bluesburguer"
  type        = string
}

#variable "vpc_cidr" {
#  description = "CIDR da VPC"
#  default     = "172.31.0.0/20"
#  type        = string
#}

variable "rds_user" {
  description = "Usuário do banco de dados RDS"
  default     = "admin"
  type        = string
}

variable "rds_pass" {
  description = "Senha do banco de dados RDS"
  default     = "Root123456!"
  type        = string
}


# variable "databaseEndpoint" {
#   default = "rds-bluesburguer.cvuiykqc6ts9.us-east-1.rds.amazonaws.com:5432"
# }

variable "tags" {
  description = "Tags para aplicar a recursos"
  type        = map(string)

  default = {
    App      = "bluesburguer"
    Ambiente = "Desenvolvimento"
  }
}

# Define a variável com a região da AWS
variable "aws_region" {
  description = "Região da AWS"
  default     = "us-east-1"
  type        = string
}

variable "repository_name" {
  description = "Nome do repositório ECR"
  default     = "ordering-system-bb-dev"
  type        = string
}

variable "load_balancer_type" {
  description = "Nome do ALB do cluster"
  default     = "application"
  type        = string
}