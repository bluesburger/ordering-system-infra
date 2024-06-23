resource "aws_secretsmanager_secret" "payment_secret" {
  name                   = "/secret/payment"
  recovery_window_in_days = 7  # Permite a exclusão do segredo após 7 dias

  # Ignorar alterações para evitar atualizações indesejadas
  lifecycle {
    ignore_changes = [
      description,      # Ignorar mudanças na descrição do segredo
      tags,             # Ignorar mudanças nas tags do segredo
    ]
  }
}

resource "aws_secretsmanager_secret_version" "payment_secret_version" {
  # Dependência explícita do recurso de segredo para garantir a criação sequencial
  depends_on = [aws_secretsmanager_secret.payment_secret]

  # Criar a versão do segredo apenas se o segredo não existir
  count = length(aws_secretsmanager_secret.payment_secret.*.arn) > 0 ? 0 : 1

  secret_id     = aws_secretsmanager_secret.payment_secret.id
  secret_string = jsonencode({
    MERCADO_PAGO_ACCESS_TOKEN = "APP_USR-7148288794739918-122720-66b9ac918d470a3bf62df3f0e6030f15-1613065352"
  })
}


