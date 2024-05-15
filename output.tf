#output "ecs-service-name-payment" {
#  value = aws_ecs_service.service_payment.name
#}
output "ecs-service-name-order" {
  value = aws_ecs_service.service_order.name
}

output "ecs-service-name-production" {
  value = aws_ecs_service.service_production.name
}

output "ecr-repository-name" {
  value = aws_ecr_repository.repository.name
}

output "ecr-repository-url" {
  value = aws_ecr_repository.repository.repository_url
}

# Saída para exibir a URL da fila SQS criada
output "queue_url" {
  value = aws_sqs_queue.order_queue.id
}