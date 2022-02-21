#security group
#bastion서버 sg
resource "aws_security_group" "bastion_sg" {
  name   = "${var.tag_name}-bastion-sg"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "bastion_sg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
  description       = "ssh"
}

#jenkins sg
resource "aws_security_group" "jenkins_sg" {
  name   = "${var.tag_name}-jenkins-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "jenkins_sg_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.jenkins_sg.id
  description              = "ssh"
}

resource "aws_security_group_rule" "jenkins_sg_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
  description       = "http"
}

#web서버 sg
resource "aws_security_group" "web_sg" {
  name   = "${var.tag_name}-web-sg"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "web_sg_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.web_sg.id
  description              = "ssh"
}

resource "aws_security_group_rule" "web_sg_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
  description              = "http"
}

#api서버 sg
resource "aws_security_group" "api_sg" {
  name   = "${var.tag_name}-api-sg"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "api_sg_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.api_sg.id
  description              = "ssh"
}
resource "aws_security_group_rule" "api_sg_tomcat" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.api_sg.id
  description              = "http"
}

#alb sg
resource "aws_security_group" "alb_sg" {
  name   = "${var.tag_name}-alb-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "alb_sg_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
  description       = "http"
}

resource "aws_security_group_rule" "alb_sg_tomcat" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
  description       = "tomcat"
}