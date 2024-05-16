output "ecs-service-name-payment" {
  value = aws_ecs_service.service_payment.name
}
output "ecs-service-name-order" {
  value = aws_ecs_service.service_order.name
}

output "ecs-service-name-production" {
  value = aws_ecs_service.service_production.name
}

output "ecr-repository-order-name" {
  value = aws_ecr_repository.repository_order.name
}

output "ecr-repository-order-url" {
  value = aws_ecr_repository.repository_order.repository_url
}

output "ecr-repository-prod-name" {
  value = aws_ecr_repository.repository_prod.name
}

output "ecr-repository-prod-url" {
  value = aws_ecr_repository.repository_prod.repository_url
}

# Saída para exibir a URL das filas SQS criadas
output "order_paid_queue" {
  value = aws_sqs_queue.order_paid_queue.id
}

output "order_in_production_queue" {
  value = aws_sqs_queue.order_in_production_queue.id
}

output "order_produced_queue" {
  value = aws_sqs_queue.order_produced_queue.id
}

output "order_delivering_queue" {
  value = aws_sqs_queue.order_delivering_queue.id
}

output "order_delivered_queue" {
  value = aws_sqs_queue.order_delivered_queue.id
}

output "order_canceled_queue" {
  value = aws_sqs_queue.order_canceled_queue.id
}