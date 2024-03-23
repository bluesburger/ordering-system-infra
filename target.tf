resource "aws_lb_target_group" "cluster-alb-target-group" {
  name        = "TG-${var.project_name}"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = data.aws_vpc.existing_vpc.id

  health_check {
    path    = "/swagger-ui/"
    port    = 8080
    matcher = "200,301"
  }
}