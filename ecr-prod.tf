resource "aws_ecr_repository" "repository_prod" {
  name                 = "ordering-system-production"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  force_delete = true
}

resource "aws_ecr_repository_policy" "repository-prod-policy" {
  repository = aws_ecr_repository.repository_prod.name

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

resource "aws_ecr_lifecycle_policy" "repository-prod-lifecycle" {
  repository = aws_ecr_repository.repository_prod.name

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

# Definição de um recurso de execução local para fazer o push da imagem "production"
resource "null_resource" "push_image_prod_to_ecr" {
  provisioner "local-exec" {
    command     = <<-EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.repository_prod.repository_url}
      mkdir -p ./temp_repo_prod
      cd ./temp_repo_prod || exit 1
      git clone https://github.com/bluesburger/orderingsystem-production ./ordering-system-repo-prod
      cd ./ordering-system-repo-prod || exit 1
      docker build --build-arg SKIP_TESTS=true -t ${aws_ecr_repository.repository_prod.repository_url}:prod .
      docker push ${aws_ecr_repository.repository_prod.repository_url}:prod
      rm -rf ./temp_repo_prod
    EOT
    working_dir = path.module
  }
  depends_on = [aws_ecr_repository.repository_prod]
}