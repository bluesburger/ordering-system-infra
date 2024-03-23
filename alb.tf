resource "aws_lb" "cluster-application-load-balancer" {
  name               = "ALB-${var.project_name}"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = data.aws_security_group.existing-load-balancer-security-group.id
  subnets            = [data.aws_subnet.existing-subnet-private-1.id, data.aws_subnet.existing-subnet-private-2.id]
  idle_timeout       = 60

}

resource "aws_lb_listener" "alb-listener-redirect" {
  load_balancer_arn = aws_lb.cluster-application-load-balancer.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cluster-alb-target-group.arn
  }
}