resource "aws_lb" "wikiAlb" {
  name               = "wikiAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.websg.id]

  enable_deletion_protection = true

  tags = {
    Environment = "Dev"
  }
}

resource "aws_lb_listener" "Wiki_Front_end" {
  load_balancer_arn = aws_lb.wikiAlb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

