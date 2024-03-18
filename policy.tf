resource "aws_iam_role_policy" "orderingsystem_role_policy_for_ecs" {
  name = "orderingsystem_role_policy_for_ecs"
  role = aws_iam_role.orderingsystem_iam_role_for_ecs.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:PullImage",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ecr:us-east-1:${data.aws_caller_identity.current.account_id}:repository/odering-system-bbs3"
      },
    ]
  })
}

resource "aws_iam_role" "orderingsystem_iam_role_for_ecs" {
  name = "orderingsystem_iam_role_for_ecs"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "orderingsystem_role_policy_attachment" {
  role       = aws_iam_role.orderingsystem_iam_role_for_ecs.name # Substitua 'example_role' pelo nome da sua função (role)
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"     # ARN da política a ser anexada

  # Opcionalmente, você pode definir um nome para o anexo da política
  # name       = "example-policy-attachment"
}