# data "aws_db_instance" "database" {
#   db_instance_identifier = "rds-${var.projectName}"
# }

# data "aws_iam_role" "ecs_task_execution_role" {
# name = "ecsTaskExecutionRole"
# arn = "arn:aws:iam::${var.AWSAccount}:role/ecsTaskExecutionRole"
# }