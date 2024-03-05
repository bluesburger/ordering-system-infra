resource "aws_ecs_task_definition" "task" {
  family = "TSK-${var.projectName}"
  container_definitions = jsonencode([
    {
      name      = "${var.projectName}"
      essential = true,
      image     = "${aws_ecr_repository.repository.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "dev"
        },
        {
          name = "SPRING_DATASOURCE_URL"
          # value = "jdbc:postgresql://${var.databaseEndpoint}/${var.projectName}"
          # Consulta endpoint na AWS
          # value = "jdbc:postgresql://${data.aws_db_instance.database.endpoint}/${var.projectName}"
          # value = "jdbc:postgresql://${aws_db_instance.rds.endpoint}/${aws_db_instance.rds.db_name}"
          value = "jdbc:postgresql://rds-bluesburguer.cvuiykqc6ts9.us-east-1.rds.amazonaws.com:5432/${var.projectName}"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "${var.rdsUser}"
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "${var.rdsPass}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group.name}"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])
  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  # execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  # execution_role_arn = "arn:aws:iam::${var.AWSAccount}:role/ecsTaskExecutionRole"
  # execution_role_arn = "arn:aws:iam::${var.AWSAccount}:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  execution_role_arn = "arn:aws:iam::${var.AWSAccount}:role/OrderingSystemServiceRoleForECS"

  memory = "4096"
  cpu    = "2048"

  # depends_on = [
  #   data.aws_iam_role.ecs_task_execution_role
  # ]
}