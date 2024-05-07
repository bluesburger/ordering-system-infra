resource "aws_ecs_cluster" "cluster" {
  name = var.clusterName

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  network_configuration {
    subnets          = [data.aws_subnet.existing_subnet1.id, data.aws_subnet.existing_subnet2.id]
    security_groups  = [data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id]
    assign_public_ip = true
  }
}
