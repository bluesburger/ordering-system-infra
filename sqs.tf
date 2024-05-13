resource "aws_sqs_queue" "order_queue" {
  name                      = "order-production-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600  # 4 dias de retenção das mensagens na fila
  visibility_timeout_seconds = 30     # Timeout de visibilidade das mensagens em segundos

  # Configuração para permitir o envio de mensagens para a fila
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.order_queue.arn}"
    }
  ]
}
EOF
}