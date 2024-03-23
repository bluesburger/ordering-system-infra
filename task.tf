resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ecs-tasks.amazonaws.com" },
        Action    = "sts:AssumeRole",
      }
    ],
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_attachment" {
  name       = "ecsTaskExecutionRoleAttachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" #TODO - somente para testes - ajustar para uma policy com permissões restritivas
}

resource "aws_ecs_task_definition" "task" {
  family                = "TSK-${var.project_name}"
  container_definitions = jsonencode([
    {
      name        = var.project_name
      essential   = true,
      image       = "${aws_ecr_repository.repository.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "dev"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database.endpoint}/${var.project_name}"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "admin" # TODO - retirar hardcoded
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "Root123456" # TODO - retirar hardcoded
        }
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = aws_cloudwatch_log_group.cloudwatch-log-group.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      },

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "4096"
  cpu                      = "2048"

  depends_on = [aws_iam_policy_attachment.ecs_task_execution_role_attachment]
}
