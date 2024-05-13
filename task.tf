//task para banco RDS ajustar para order ou menu
#resource "aws_ecs_task_definition" "task" {
#  family = "TSK-${var.projectName}"
#  container_definitions = jsonencode([
#    {
#      name      = "${var.projectName}"
#      essential = true,
#      image     = "${aws_ecr_repository.repository.repository_url}:latest",
#      environment = [
#        {
#          name  = "SPRING_PROFILES_ACTIVE"
#          value = "dev"
#        },
#        {
#          name  = "SPRING_DATASOURCE_URL"
#          value = "jdbc:mysql://${data.aws_db_instance.database.endpoint}/${var.projectName}"
#        },
#        {
#          name  = "SPRING_DATASOURCE_USERNAME"
#          value = "${var.rdsUser}"
#        },
#        {
#          name  = "SPRING_DATASOURCE_PASSWORD"
#          value = "${var.rdsPass}"
#        }
#      ]
#      logConfiguration = {
#        logDriver = "awslogs"
#        options = {
#          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group.name}"
#          awslogs-region        = "us-east-1"
#          awslogs-stream-prefix = "ecs"
#        }
#      }
#      portMappings = [
#        {
#          containerPort = 8080
#          hostPort      = 8080
#          protocol      = "tcp"
#        }
#      ]
#    }
#  ])
#  network_mode = "awsvpc"
#
#  requires_compatibilities = ["FARGATE"]
#
#  # execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
#  # execution_role_arn = "arn:aws:iam::${var.AWSAccount}:role/ecsTaskExecutionRole"
#  # execution_role_arn = "arn:aws:iam::${var.AWSAccount}:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
#  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"
#
#  memory = "4096"
#  cpu    = "2048"
#
#  # depends_on = [
#  #   data.aws_iam_role.ecs_task_execution_role
#  # ]
#}


resource "aws_ecs_task_definition" "task" {
  family = "TSK-${var.projectName}"

  container_definitions = jsonencode([
    {
      name      = "${var.project_name_dynamo}"
      essential = true,
      image     = "${aws_ecr_repository.repository.repository_url}:payment",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "dev"
        },
        {
          name  = "NOTIFICATION_URL"
          value = "url_test"
        },
        {
          name  = "AWS_ACCESS_SECRET_KEY"
          value = var.aws_secret_key
        },
        {
          name  = "AWS_ACCESS_KEY_ID"
          value = var.aws_access_key
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group.name}"
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

  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Use a role IAM adequada que permita acesso ao DynamoDB
  # Certifique-se de que esta role tenha as permissões necessárias para acessar o DynamoDB
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  # Configuração de recursos para a task
  memory = "4096"
  cpu    = "2048"
}

//task para order
resource "aws_ecs_task_definition" "task" {
  family = "TSK-${var.projectName}"
  container_definitions = jsonencode([
    {
      name      = "${var.project_name_order}"
      essential = true,
      image     = "${aws_ecr_repository.repository.repository_url}:order",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "dev"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database.endpoint}/${var.projectName}"
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
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  memory = "4096"
  cpu    = "2048"

  # depends_on = [
  #   data.aws_iam_role.ecs_task_execution_role
  # ]
}