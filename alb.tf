resource "aws_lb" "alb" {
  name               = "ALB-${var.projectName}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
  subnets            = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}"]
  idle_timeout       = 60

}

resource "aws_lb_listener" "alb-listener-redirect_prod" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "90"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_prod.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_order" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_payment" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "70"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_payment.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_menu" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "60"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_menu.arn
  }
}