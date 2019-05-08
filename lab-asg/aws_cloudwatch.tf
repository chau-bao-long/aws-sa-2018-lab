resource "aws_cloudwatch_metric_alarm" "app_high" {
  alarm_name = "app-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "60"
  treat_missing_data = "missing"
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.app_scale_out.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "app_low" {
  alarm_name = "app-cpu-utilization-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "10"
  treat_missing_data = "missing"
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.app_scale_in.arn}"]
}
