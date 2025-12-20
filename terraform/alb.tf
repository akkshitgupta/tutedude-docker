resource "aws_lb" "alb" {
  load_balancer_type = "application"
  subnets            = aws_subnet.part-3-subnet-public[*].id
  security_groups    = [aws_security_group.part-3-alb_sg.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code = "404"
    }
  }
}


# path based routing for Flask and Express services
resource "aws_lb_target_group" "flask" {
  port        = 8000
  protocol    = "HTTP"
  vpc_id     = aws_vpc.part-3-vpc.id
  target_type = "ip"
}

resource "aws_lb_target_group" "express" {
  port        = 3000
  protocol    = "HTTP"
  vpc_id     = aws_vpc.part-3-vpc.id
  target_type = "ip"
}

# listener rules for path based routing
resource "aws_lb_listener_rule" "flask" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  condition {
    path_pattern {
      values = ["/backend*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask.arn
  }
}

resource "aws_lb_listener_rule" "express" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/frontend*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.express.arn
  }
}


