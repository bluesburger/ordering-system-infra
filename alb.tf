resource "aws_lb" "alb" {
  name               = "ALB-${var.projectName}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg.id}"]
  subnets            = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}", "${data.aws_subnet.existing_subnet3.id}"]
  idle_timeout       = 60

}

resource "aws_lb_listener" "alb-listener-redirect" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}