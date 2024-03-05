output "ecs-service-name" {
  value = aws_ecs_service.service.name
}

output "ecr-repository-name" {
  value = aws_ecr_repository.repository.name
}

output "ecr-repository-url" {
  value = aws_ecr_repository.repository.repository_url
}
