# Recurso para criar um repositório ECR
resource "aws_ecr_repository" "repository" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  force_delete = true
}

# Política de acesso ao repositório ECR
resource "aws_ecr_repository_policy" "repository-policy" {
  repository = aws_ecr_repository.repository.name

  policy = jsonencode({
    Version   = "2008-10-17",
    Statement = [
      {
        Sid       = "AllowAccess",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  })
}

# Política de ciclo de vida para o repositório ECR
resource "aws_ecr_lifecycle_policy" "repository-lifecycle" {
  repository = aws_ecr_repository.repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire images count more than 2",
        selection    = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = 2
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# Provê a autenticação e faz o push da imagem para o repositório ECR.
resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command     = <<-EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.repository.registry_id}.dkr.ecr.${var.aws_region}.amazonaws.com
      mkdir -p ./temp_repo
      cd ./temp_repo || exit 1
      git clone https://github.com/bluesburger/ordering-system ./ordering-system-repo
      cd ./ordering-system-repo || exit 1
      docker build -t ${aws_ecr_repository.repository.repository_url}:latest .
      docker push ${aws_ecr_repository.repository.repository_url}:latest
      rm -rf ./temp_repo
    EOT
    working_dir = path.module
  }
  depends_on = [aws_ecr_repository.repository]
}
