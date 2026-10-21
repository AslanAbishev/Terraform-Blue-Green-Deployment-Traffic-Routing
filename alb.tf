resource "aws_lb_target_group" "blue" {
  name     = local.blue_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = local.blue_tg_name
    Project     = var.project_id
    Environment = "Blue"
    Terraform   = "true"
  }
}

resource "aws_lb_target_group" "green" {
  name     = local.green_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = local.green_tg_name
    Project     = var.project_id
    Environment = "Green"
    Terraform   = "true"
  }
}

resource "aws_lb" "main" {
  name               = local.lb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.lb.id
  ]

  subnets = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  tags = {
    Name      = local.lb_name
    Project   = var.project_id
    Terraform = "true"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }
}
