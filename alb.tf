resource "aws_lb" "alb" {
  name               = "ALB-${var.projectName}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.other_repo.outputs.public_subnet_sg_id}"]
  subnets            = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}"]
  idle_timeout       = 60

}

resource "aws_lb" "nlb" {
  name               = "NLB-${var.projectName}"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${data.aws_subnet.existing_subnet1.id}", "${data.aws_subnet.existing_subnet2.id}"]
}

resource "aws_lb_listener" "alb-listener-default" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8022"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_order.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_prod" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8023"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_prod.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_payment" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8021"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_payment.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_menu" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8020"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_menu.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_stock" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8024"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_stock.arn
  }
}

resource "aws_lb_listener" "alb-listener-redirect_invoice" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8025"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_invoice.arn
  }
}

resource "aws_lb_listener_rule" "order" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_order.arn
  }
  condition {
    path_pattern {
      values = ["/order*"]
    }
  }
}

resource "aws_lb_listener_rule" "payment" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 20
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_payment.arn
  }
  condition {
    path_pattern {
      values = ["/payment*"]
    }
  }
}

resource "aws_lb_listener_rule" "menu" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 30
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_menu.arn
  }
  condition {
    path_pattern {
      values = ["/menu*"]
    }
  }
}


resource "aws_lb_listener_rule" "prod" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 40
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_prod.arn
  }
  condition {
    path_pattern {
      values = ["/prod*"]
    }
  }
}

resource "aws_lb_listener_rule" "stock" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 50
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_stock.arn
  }
  condition {
    path_pattern {
      values = ["/stock*"]
    }
  }
}

resource "aws_lb_listener_rule" "invoice" {
  listener_arn = aws_lb_listener.alb-listener-default.arn
  priority     = 50
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_invoice.arn
  }
  condition {
    path_pattern {
      values = ["/invoice*"]
    }
  }
}