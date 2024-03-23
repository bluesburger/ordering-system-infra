resource "aws_ecs_cluster" "cluster" {
  name = var.project_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

