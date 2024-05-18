resource "aws_ecs_service" "service_menu" {
  name            = "SVC-${var.project_name_menu}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_menu.arn

  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}", "${data.aws_subnet.existing_subnet3.id}", "${data.aws_subnet.existing_subnet4.id}"]
    security_groups  = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 240

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_menu.arn
    container_name   = var.project_name_menu
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

  depends_on = [aws_lb.alb]
}

resource "aws_ecs_service" "service_payment" {
  name            = "SVC-${var.project_name_dynamo}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_payment.arn

  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}", "${data.aws_subnet.existing_subnet3.id}", "${data.aws_subnet.existing_subnet4.id}"]
    security_groups  = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 240

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_payment.arn
    container_name   = var.project_name_dynamo
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

  depends_on = [aws_lb.alb]
}

resource "aws_ecs_service" "service_order" {
  name            = "SVC-${var.project_name_order}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_order.arn

  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}", "${data.aws_subnet.existing_subnet3.id}", "${data.aws_subnet.existing_subnet4.id}"]
    security_groups  = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 240

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.project_name_order
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

  depends_on = [aws_lb.alb]
}

resource "aws_ecs_service" "service_production" {
  name            = "SVC-${var.project_name_production}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_production.arn

  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}", "${data.aws_subnet.existing_subnet3.id}", "${data.aws_subnet.existing_subnet4.id}"]
    security_groups  = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 240

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_prod.arn
    container_name   = var.project_name_production
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

  depends_on = [aws_lb.alb]
}