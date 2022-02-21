#autoscaling
#web launch template
resource "aws_launch_template" "web_launch_template" {
  name_prefix            = "${var.tag_name}-web-launch-template"
  image_id               = var.web_image_id
  instance_type          = var.web_instance_type
  key_name               = var.web_key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "${var.tag_name}-web-launch-template"
  }
  default_version = 1
  //update_default_version = true 이 코드와 같다. terraform 적용 시 default_version을 최신 버전으로 업데이트한다는 뜻
}

#web autoscaling group
resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.tag_name}-web-asg"
  vpc_zone_identifier = [aws_subnet.private1.id, aws_subnet.private2.id]
  desired_capacity    = var.web_asg_capacity_desired
  max_size            = var.web_asg_capacity_max
  min_size            = var.web_asg_capacity_min
  tag {
    key                 = "Name"
    value               = "${var.tag_name}-web"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoScaler"
    value               = true
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = 1
  }

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.tg_web.arn]
}


#web autoscaling group policy
resource "aws_autoscaling_policy" "web_scale_up_policy" {
  name                   = "${var.tag_name}-web-scale-up-policy"
  scaling_adjustment     = var.web_scale_up
  adjustment_type        = var.web_adjustment_type
  //cpu_scaleup_threshold  = var.web_cpu_scaleup_threshold
  cooldown               = 300 //조정 활동이 완료된 후 다음 조정 활동을 시작할 수 있을 때까지의 시간(초).
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

resource "aws_autoscaling_policy" "web_scale_down_policy" {
  name                   = "${var.tag_name}-web-scale-dwon-policy"
  scaling_adjustment     = var.web_scale_down
  adjustment_type        = var.web_adjustment_type
  //cpu_scaleup_threshold  = var.web_cpu_scaledown_threshold
  cooldown               = 300 //조정 활동이 완료된 후 다음 조정 활동을 시작할 수 있을 때까지의 시간(초).
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

/*
policy_type(선택 사항)
"SimpleScaling", "StepScaling", "TargetTrackingScaling" 또는 "PredictiveScaling" 정책 유형
이 값이 제공되지 않으면 AWS는 기본적으로 "SimpleScaling"으로 설정된다.
"SimpleScaling" = 단순조정, "StepScaling" = 단계조정
*/

#api launch tamplate
resource "aws_launch_template" "api_launch_template" {
  name_prefix            = "${var.tag_name}-api-launch-template"
  image_id               = var.api_image_id
  instance_type          = var.api_instance_type
  key_name               = var.api_key_name
  vpc_security_group_ids = [aws_security_group.api_sg.id]
  tags = {
    Name = "${var.tag_name}-api-launch-template"
  }
  default_version = 1
}

resource "aws_autoscaling_group" "api_asg" {
  name                = "${var.tag_name}-api-asg"
  vpc_zone_identifier = [aws_subnet.private1.id, aws_subnet.private2.id]
  desired_capacity    = var.api_asg_capacity_desired
  max_size            = var.api_asg_capacity_max
  min_size            = var.api_asg_capacity_min

  launch_template {
    id      = aws_launch_template.api_launch_template.id
    version = 1
  }

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  timeouts {
    delete = "15m"
  }
  tag {
    key                 = "Name"
    value               = "${var.tag_name}-api"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoScaler"
    value               = true
    propagate_at_launch = true
  }

}

#api autoscaling group policy
resource "aws_autoscaling_policy" "api_scale_up_policy" {
  name                   = "${var.tag_name}-api-asg-policy"
  scaling_adjustment     = var.api_scale_up
  adjustment_type        = var.api_adjustment_type
  //cpu_scaleup_threshold  = var.api_cpu_scaleup_threshold
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}
resource "aws_autoscaling_policy" "api_scale_down_policy" {
  name                    = "${var.tag_name}-api-scale-down-policy"
  scaling_adjustment      = var.api_scale_down
  adjustment_type         = var.api_adjustment_type
  //cpu_scaledown_threshold = var.api_cpu_scaledown_threshold
  cooldown                = 300
  autoscaling_group_name  = aws_autoscaling_group.api_asg.name
}


