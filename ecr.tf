resource "aws_ecr_repository" "repository" {
  name                 = "ordering-systems3"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  force_delete = true
}

resource "aws_ecr_repository_policy" "repository-policy" {
  repository = aws_ecr_repository.repository.name

  policy = <<EOF
  {
     "Version": "2008-10-17",
     "Statement": [
         {
             "Sid": "new policy",
             "Effect": "Allow",
             "Principal": {
                 "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
             },
             "Action": [
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
 }
 EOF
}

resource "aws_ecr_lifecycle_policy" "repository-lifecycle" {
  repository = aws_ecr_repository.repository.name

  policy = <<EOF
 {
     "rules": [
         {
             "rulePriority": 1,
             "description": "Expire images count more than 2",
             "selection": {
                 "tagStatus": "any",
                 "countType": "imageCountMoreThan",
                 "countNumber": 2
             },
             "action": {
                 "type": "expire"
             }
         }
     ]
 }
 EOF
}


# Definição de um recurso de execução local para fazer o push da imagem
resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com && docker build -t ${aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.repository.name}:latest . && docker push ${aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.repository.name}:latest"
  }

  depends_on = [aws_ecr_repository.repository]
}
