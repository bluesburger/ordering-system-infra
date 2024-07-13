resource "aws_ecr_repository" "repository_menu" {
  name                 = "ordering-system-menu"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  force_delete = true
}

resource "aws_ecr_repository_policy" "repository-menu-policy" {
  repository = aws_ecr_repository.repository_menu.name

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

resource "aws_ecr_lifecycle_policy" "repository-menu-lifecycle" {
  repository = aws_ecr_repository.repository_menu.name

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

resource "null_resource" "push_image_menu_to_ecr" {
  provisioner "local-exec" {
    command     = <<-EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.repository_menu.repository_url}
      mkdir -p ./temp_repo_menu  # Cria diretório temporário exclusivo para o pedido
      cd ./temp_repo_menu || exit 1
      git clone https://github.com/bluesburger/ordering-system-microsservice-menu ./ordering-system-repo-menu
      cd ./ordering-system-repo-menu || exit 1
      docker build -t ${aws_ecr_repository.repository_menu.repository_url}:latest .
      docker push ${aws_ecr_repository.repository_menu.repository_url}:latest
      rm -rf ./temp_repo_menu
    EOT
    working_dir = path.module
  }
  depends_on = [aws_ecr_repository.repository_menu]
}

