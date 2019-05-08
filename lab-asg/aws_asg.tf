resource "aws_launch_configuration" "lcf" {
  name = "lab-architect-lcf-web-front"
  image_id = "${var.amis["test_ami"]}"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [
    "${aws_security_group.sg_alb.id}"
  ]
  root_block_device = {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "lab-architect-asg-web-front"
  launch_configuration = "${aws_launch_configuration.lcf.name}"
  vpc_zone_identifier = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}"
  ]
  availability_zones = [
    "${var.public_az_a}",
    "${var.public_az_b}",
  ]
  max_size = 4
  min_size = 2
  desired_capacity = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  termination_policies = ["NewestInstance"]
  target_group_arns = [
    "${aws_lb_target_group.alb_tg.arn}"
  ]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
  lifecycle {
    create_before_destroy = true
  }
  tags = [
    {
      key = "Name"
      value = "lab-architect-web-front"
      propagate_at_launch = true
    },
    {
      key = "ServerType"
      value = "frontend"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "dev"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscaling_policy" "app_scale_out" {
  name = "instance-scale-out-cpu-high"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_autoscaling_policy" "app_scale_in" {
  name = "instance-scale-in-cpu-low"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}
