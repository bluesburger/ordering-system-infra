resource "aws_appautoscaling_target" "autoscaling_target_production" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${var.clusterName}/${aws_ecs_service.service_production.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  tags = var.tags
}

resource "aws_appautoscaling_policy" "memory_policy_production" {
  name               = "scaleby-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_target_stock.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_target_stock.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_target_stock.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = 5
  }
}

resource "aws_appautoscaling_policy" "cpu_policy_production" {
  name               = "scaleby-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_target_stock.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_target_stock.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_target_stock.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 3
  }
}