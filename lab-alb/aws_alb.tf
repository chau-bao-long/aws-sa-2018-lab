resource "aws_lb" "web_alb" {
  name = "lab-architect-alb-front"
  internal = false
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.sg_alb.id}"]
  subnets = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}",
  ]
  ip_address_type = "ipv4"
  enable_deletion_protection = true
  idle_timeout = 60
  enable_http2 = true
  tags = {
    Name = "lab-architect-alb-front"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name = "lab-architect-alb-tgp-front"
  protocol = "HTTP"
  port = 80
  vpc_id = "${aws_vpc.vpc_main.id}"
  target_type = "instance"
  deregistration_delay = 300
  stickiness = {
    type = "lb_cookie"
    enabled = false
  }
  health_check = {
    protocol = "HTTP"
    path = "/"
    port = 80
    healthy_threshold = 5
    unhealthy_threshold = 3
    timeout = 5
    interval = 20
    matcher = 200
  }
}

resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = "${aws_lb.web_alb.arn}"
  port = "80"
  protocol = "HTTP"
  default_action = {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
  }
}

# resource "aws_lb_listener" "front_end_https" {
#   load_balancer_arn = "${aws_lb.web_alb.arn}"
#   port = "443"
#   protocol = "HTTPS"
#   ssl_policy = "ELBSecurityPolicy-2016-08"
#   certificate_arn = "arn:aws:acm:ap-northeast-1:771306112264:certificate/4acc36a1-8e15-46e5-8490-8ff490cd2064"
#   default_action = {
#     type = "forward"
#     target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
#   }
# }

resource "aws_lb_target_group_attachment" "lb_tg_attachment_1" {
  target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
  target_id        = "${aws_instance.web_instance_1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_tg_attachment_2" {
  target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
  target_id        = "${aws_instance.web_instance_2.id}"
  port             = 80
}
