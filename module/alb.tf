#alb 설정
resource "aws_lb" "alb" {
  name               = "${var.tag_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  enable_cross_zone_load_balancing = true
}

#target group 생성
resource "aws_lb_target_group" "tg_web" {
  name     = "${var.tag_name}-tg-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
resource "aws_lb_target_group" "tg_api" {
  name     = "${var.tag_name}-tg-api"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

#lb - target group listener설정
resource "aws_alb_listener" "alb_listener_web" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web.arn
  }

}

resource "aws_alb_listener" "alb_listener_api" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_api.arn
  }
}

#web autoscaling group을 lb의 target group에 붙이기
resource "aws_autoscaling_attachment" "web" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  alb_target_group_arn   = aws_lb_target_group.tg_web.arn
}

#api autoscaling group을 lb의 target group에 붙이기
resource "aws_autoscaling_attachment" "api" {
  autoscaling_group_name = aws_autoscaling_group.api_asg.id
  alb_target_group_arn   = aws_lb_target_group.tg_api.arn
}