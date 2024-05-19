resource "aws_lb_target_group" "tg_order" {
  name        = "TG-${var.projectName}"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = data.aws_vpc.existing_vpcs.id

  health_check {
    path    = "/actuator/health"
    port    = 8080
    matcher = "200,301"
  }
}

resource "aws_lb_target_group" "tg_prod" {
  name        = "TG-${var.projectName}-prod"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = data.aws_vpc.existing_vpcs.id

  health_check {
    path    = "/actuator/health"
    port    = 8080
    matcher = "200,301"
  }
}

resource "aws_lb_target_group" "tg_payment" {
  name        = "TG-${var.projectName}-payment"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = data.aws_vpc.existing_vpcs.id

  health_check {
    path    = "/swagger-ui/index.html"
    port    = 8080
    matcher = "200,301"
  }
}

resource "aws_lb_target_group" "tg_menu" {
  name        = "TG-${var.projectName}-menu"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = data.aws_vpc.existing_vpcs.id

  health_check {
    path    = "/swagger-ui/index.html"
    port    = 8080
    matcher = "200,301"
  }
}