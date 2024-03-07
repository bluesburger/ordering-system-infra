resource "aws_lb_target_group" "tg" {
  name        = "TG-${var.projectName}"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = var.vpcId

  health_check {
    path    = "/swagger-ui/"
    port    = 8080
    matcher = "200,301"
  }
}