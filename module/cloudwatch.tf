#cloudwatch alarm with autoscaling
#web alarm
resource "aws_cloudwatch_metric_alarm" "web_cpu_high" {
  alarm_name          = "${var.tag_name}-web-cpu-util-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.web_cpu_scaleup_threshold
  alarm_description   = "This metric monitors web-ec2 cpu for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.web_scale_up_policy.arn}" //"${aws_sns_topic.topic.arn}"sns사용시에만 입력
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web_asg.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_low" {
  alarm_name          = "${var.tag_name}-web-cpu-util-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.web_cpu_scaledown_threshold
  alarm_description   = "This metric monitors web-ec2 cpu for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.web_scale_down_policy.arn}" //"${aws_sns_topic.topic.arn}" sns 사용시에만 입력
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web_asg.name}"
  }
}

#api alarm
resource "aws_cloudwatch_metric_alarm" "api-cpu-high" {
  alarm_name          = "${var.tag_name}-api-cpu-util-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.api_cpu_scaleup_threshold
  alarm_description   = "This metric monitors api-ec2 cpu for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.api_scale_up_policy.arn}" #"${aws_sns_topic.topic.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.api_asg.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "api-cpu-low" {
  alarm_name          = "${var.tag_name}-api-cpu-util-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.api_cpu_scaledown_threshold
  alarm_description   = "This metric monitors api-ec2 cpu for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.api_scale_down_policy.arn}" #"${aws_sns_topic.topic.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "{aws_autoscaling_group.api_asg.name}"
  }
}