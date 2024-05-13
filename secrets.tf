resource "aws_secretsmanager_secret" "payment_secret" {
  name                   = "/secret/payment"
  recovery_window_in_days = 7  # Permite a exclusão do segredo após 7 dias
}

resource "aws_secretsmanager_secret_version" "payment_secret_version" {
  secret_id     = aws_secretsmanager_secret.payment_secret.id
  secret_string = "{\"MERCADO_PAGO_ACCESS_TOKEN\":\"APP_USR-7148288794739918-122720-66b9ac918d470a3bf62df3f0e6030f15-1613065352\"}"
}