resource "aws_ecs_service" "service" {
  name            = "SVC-${var.project_name}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task.arn

  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = [data.aws_subnet.existing-subnet-private-1.id, data.aws_subnet.existing-subnet-private-2.id]
    security_groups  = [data.aws_security_group.existing-cluster-security-group.id]
    assign_public_ip = false
  }

  health_check_grace_period_seconds = 300

  load_balancer {
    target_group_arn = aws_lb_target_group.cluster-alb-target-group.arn
    container_name   = var.project_name
    container_port   = 8080
  }

  capacity_provider_strategy {
    base              = 1
    capacity_provider = "FARGATE"
    weight            = 1
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  depends_on = [aws_lb.cluster-application-load-balancer]
}