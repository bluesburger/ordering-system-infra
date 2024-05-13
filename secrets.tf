# Verifica se o segredo /secret/payment já existe
data "aws_secretsmanager_secret" "existing_payment_secret" {
  name = "/secret/payment"
}

# Cria o segredo somente se ele não existir
resource "aws_secretsmanager_secret" "payment_secret" {
  count = length(data.aws_secretsmanager_secret.existing_payment_secret) > 0 ? 0 : 1

  name = "/secret/payment"
}

# Cria a versão do segredo somente se o segredo precisar ser criado
resource "aws_secretsmanager_secret_version" "payment_secret_version" {
  count         = aws_secretsmanager_secret.payment_secret[*].id != "" ? 0 : 1
  secret_id     = aws_secretsmanager_secret.payment_secret.id
  secret_string = jsonencode({
    MERCADO_PAGO_ACCESS_TOKEN = "APP_USR-7148288794739918-122720-66b9ac918d470a3bf62df3f0e6030f15-1613065352"
  })
}