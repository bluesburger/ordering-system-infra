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

resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command = <<-EOT
      $(aws ecr get-login --no-include-email --region ${var.aws_region})
      docker build -t ${aws_ecr_repository.repository.name}:latest .
      docker push ${aws_ecr_repository.repository.name}:latest
    EOT
  }

  depends_on = [aws_ecr_repository.repository]
}


resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command = <<-EOT
      $(aws ecr get-login --no-include-email --region ${var.aws_region})
      wget -O Dockerfile https://github.com/bluesburger/ordering-system/blob/main/Dockerfile
      docker build -t ${aws_ecr_repository.repository.name}:latest .
      docker push ${aws_ecr_repository.repository.name}:latest
      rm Dockerfile  # Remove o Dockerfile após a conclusão
    EOT

    working_dir = "${path.module}"  # Define o diretório de trabalho como o diretório do arquivo Terraform
  }

  depends_on = [aws_ecr_repository.repository]
}