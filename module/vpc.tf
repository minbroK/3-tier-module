resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.tag_name}-vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_block1
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "${var.tag_name}-public-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_block2
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "${var.tag_name}-public-subnet2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_block1
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "${var.tag_name}-private-subnet1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_block2
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "${var.tag_name}-private-subnet2"
  }
}

resource "aws_subnet" "rds1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.rds_subnet_cidr_block1
 availability_zone = "ap-northeast-2a"
  tags = {
    Name = "${var.tag_name}-rds-subnet1"
  }
}

resource "aws_subnet" "rds2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.rds_subnet_cidr_block2
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "${var.tag_name}-rds-subnet2"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id
  tags = {
    Name = "${var.tag_name}-nat1"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.tag_name}-public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.tag_name}-private-route-table"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds1" {
  subnet_id      = aws_subnet.rds1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds2" {
  subnet_id      = aws_subnet.rds2.id
  route_table_id = aws_route_table.private.id
}