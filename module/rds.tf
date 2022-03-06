#rds 생성
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.tag_name}-rds-subnet-group"
  subnet_ids = [
    aws_subnet.rds1.id,
    aws_subnet.rds2.id
  ]

  tags = {
    "Name" = "${var.tag_name}-rds-subnet-group"
  }

}
resource "aws_db_instance" "rds" {
  availability_zone    = "ap-northeast-2a"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  instance_class       = var.rds_instance_type
  skip_final_snapshot  = true
  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  allocated_storage    = var.allocated_storage
  //max_allocated_storage = var.max_allocated_storage
  multi_az             = var.multi_az

  username = var.rds_username
  password = var.rds_password
}

