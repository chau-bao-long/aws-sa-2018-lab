resource "aws_elb" "web_elb" {
  name = "lab-architect-elb-web"
  internal = false
  listener {
    lb_protocol = "http"
    lb_port = 80
    instance_protocol = "http"
    instance_port = 80
  }
  subnets = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}",
  ]
  security_groups = [
    "${aws_security_group.sg_elb.id}",
  ]
  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    target = "TCP:80"
  }
  instances = [
    "${aws_instance.web_instance_1.id}",
    "${aws_instance.web_instance_2.id}",
  ]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 300
  tags = {
    Name = "lab-architect-elb-web"
  }
}
