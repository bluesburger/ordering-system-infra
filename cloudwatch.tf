resource "aws_cloudwatch_log_group" "cloudwatch-log-group" {
  name              = "ecs/${var.projectName}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-payment" {
  name              = "ecs/${var.project_name_dynamo}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-menu" {
  name              = "ecs/${var.project_name_menu}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-order" {
  name              = "ecs/${var.project_name_order}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-stock" {
  name              = "ecs/${var.project_name_stock}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-production" {
  name              = "ecs/${var.project_name_production}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_stream" "cloudwatch-log-stream" {
  name           = "ecs"
  log_group_name = aws_cloudwatch_log_group.cloudwatch-log-group.name
}