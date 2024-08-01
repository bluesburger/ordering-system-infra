//task para banco RDS ajustar para order ou menu
resource "aws_ecs_task_definition" "task_menu" {
  family = "TSK-${var.projectName}"
  container_definitions = jsonencode([
    {
      name      = "${var.project_name_menu}"
      essential = true,
      image     = "${aws_ecr_repository.repository_menu.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "production"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database_menu.endpoint}/dbbluesburgermenu?useSSL=false&useTimezone=true&serverTimezone=UTC"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "${var.rdsUser}"
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "${var.rdsPass}"
        },
        {
          name  = "SPRING_JPA_GENERATE_DDL"
          value = "true"
        },
        {
          name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
          value = "update"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-menu.name}"
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

resource "aws_ecs_task_definition" "task_payment" {
  family = "TSK-${var.projectName}"

  container_definitions = jsonencode([
    {
      name      = "${var.project_name_dynamo}"
      essential = true,
      image     = "${aws_ecr_repository.repository_payment.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "prod"
        },
        {
          name  = "NOTIFICATION_URL"
          value = "http://${aws_lb.alb.dns_name}:70/api/v1/payment/webhook"
        },
        {
          name  = "AWS_ACCESS_KEY_ID"
          value = "${var.aws_access_key}"
        },
        {
          name  = "AWS_SECRET_ACCESS_KEY"
          value = "${var.aws_secret_key}"
        },
        {
          name  = "SQS_PRODUCTION_QUEUE",
          value = "bill-performed-event.fifo"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-payment.name}"
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

  # Use a role IAM adequada que permita acesso ao DynamoDB
  # Certifique-se de que esta role tenha as permissões necessárias para acessar o DynamoDB
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  # Configuração de recursos para a task
  memory = "4096"
  cpu    = "2048"
}

//task para order
resource "aws_ecs_task_definition" "task_order" {
  family = "TSK-${var.projectName}"
  container_definitions = jsonencode([
    {
      name      = "${var.project_name_order}"
      essential = true,
      image     = "${aws_ecr_repository.repository_order.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "production"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database.endpoint}/dbbluesburger?useSSL=false&useTimezone=true&serverTimezone=UTC"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "${var.rdsUser}"
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "${var.rdsPass}"
        },
        {
          name  = "SPRING_JPA_GENERATE_DDL"
          value = "true"
        },
        {
          name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
          value = "update"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-order.name}"
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


resource "aws_ecs_task_definition" "task_production" {
  family = "TSK-${var.projectName}"

  container_definitions = jsonencode([
    {
      name      = "${var.project_name_production}"
      essential = true,
      image     = "${aws_ecr_repository.repository_prod.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "production"
        },
        {
          name  = "AWS_ACCESS_KEY_ID"
          value = "${var.aws_access_key}"
        },
        {
          name  = "AWS_SECRET_ACCESS_KEY"
          value = "${var.aws_secret_key}"
        },
        {
          name  = "NOTIFICATION_URL"
          value = "url_test"
        },
        {
          name  = "ORDER_ENDPOINT_HOST",
          value = "http://${aws_lb.alb.dns_name}"
        },
        {
          name = "AWS_ENDPOINT_URI",
          value = "https://sqs.us-east-1.amazonaws.com"
        },
        {
          name = "AWS_ACCOUNT_ID",
          value = "${data.aws_caller_identity.current.account_id}"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-production.name}"
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

  # Use a role IAM adequada que permita acesso ao DynamoDB
  # Certifique-se de que esta role tenha as permissões necessárias para acessar o DynamoDB
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  # Configuração de recursos para a task
  memory = "4096"
  cpu    = "2048"
}

resource "aws_ecs_task_definition" "task_stock" {
  family = "TSK-${var.projectName}"

  container_definitions = jsonencode([
    {
      name      = "${var.project_name_stock}"
      essential = true,
      image     = "${aws_ecr_repository.repository_stock.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "production"
        },
        {
          name  = "AWS_ACCESS_KEY_ID"
          value = "${var.aws_access_key}"
        },
        {
          name  = "AWS_SECRET_ACCESS_KEY"
          value = "${var.aws_secret_key}"
        },
        {
          name  = "NOTIFICATION_URL"
          value = "url_test"
        },
        {
          name  = "ORDER_ENDPOINT_HOST",
          value = "http://${aws_lb.alb.dns_name}"
        },
        {
          name = "AWS_ENDPOINT_URI",
          value = "https://sqs.us-east-1.amazonaws.com"
        },
        {
          name = "AWS_ACCOUNT_ID",
          value = "${data.aws_caller_identity.current.account_id}"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database_stock.endpoint}/dbbluesburgerstock?useSSL=false&useTimezone=true&serverTimezone=UTC"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "${var.rdsUser}"
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "${var.rdsPass}"
        },
        {
          name  = "SPRING_JPA_GENERATE_DDL"
          value = "true"
        },
        {
          name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
          value = "update"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-stock.name}"
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

  # Use a role IAM adequada que permita acesso ao DynamoDB
  # Certifique-se de que esta role tenha as permissões necessárias para acessar o DynamoDB
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  # Configuração de recursos para a task
  memory = "4096"
  cpu    = "2048"
}

resource "aws_ecs_task_definition" "task_invoice" {
  family = "TSK-${var.projectName}"

  container_definitions = jsonencode([
    {
      name      = "${var.project_name_invoice}"
      essential = true,
      image     = "${aws_ecr_repository.repository_invoice.repository_url}:latest",
      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "production"
        },
        {
          name  = "AWS_ACCESS_KEY_ID"
          value = "${var.aws_access_key}"
        },
        {
          name  = "AWS_SECRET_ACCESS_KEY"
          value = "${var.aws_secret_key}"
        },
        {
          name  = "NOTIFICATION_URL"
          value = "url_test"
        },
        {
          name  = "ORDER_ENDPOINT_HOST",
          value = "http://${aws_lb.alb.dns_name}"
        },
        {
          name = "AWS_ENDPOINT_URI",
          value = "https://sqs.us-east-1.amazonaws.com"
        },
        {
          name = "AWS_ACCOUNT_ID",
          value = "${data.aws_caller_identity.current.account_id}"
        },
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${data.aws_db_instance.database_invoice.endpoint}/dbbluesburgerinvoice?useSSL=false&useTimezone=true&serverTimezone=UTC"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "${var.rdsUser}"
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "${var.rdsPass}"
        },
        {
          name  = "SPRING_JPA_GENERATE_DDL"
          value = "true"
        },
        {
          name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
          value = "update"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloudwatch-log-group-invoice.name}"
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

  # Use a role IAM adequada que permita acesso ao DynamoDB
  # Certifique-se de que esta role tenha as permissões necessárias para acessar o DynamoDB
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/OrderingSystemServiceRoleForECS"

  # Configuração de recursos para a task
  memory = "4096"
  cpu    = "2048"
}