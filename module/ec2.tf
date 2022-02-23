/*
#terraform으로 key를 생성하면 ec2가 갖게 되는 public key만 생성할 수 있고, private key를 추출하기 어려우므로 aws console에서 키를 만들고 그 키의 이름을 코드에서 사용
*/
resource "aws_instance" "bastion" {
  ami                    = var.bastion_image_id
  instance_type          = var.bastion_instance_type
  key_name               = var.bastion_key_name
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = {
    "Name" = "${var.tag_name}-bastion"
  }
}


resource "aws_instance" "jenkins" {
  ami                    = var.jenkins_image_id
  instance_type          = var.jenkins_instance_type
  key_name               = var.jenkins_key_name
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = {
    "Name" = "${var.tag_name}-jenkins"
  }
}

