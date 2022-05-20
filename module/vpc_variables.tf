variable "tag_name" {
  type    = string
  default = "mhkim-stg"
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnet_cidr_block1" {
  type = string
}


variable "public_subnet_cidr_block2" {
  type = string
}


variable "private_subnet_cidr_block1" {
  type = string
}

variable "private_subnet_cidr_block2" {
  type = string
}


variable "rds_subnet_cidr_block1" {
  type = string
}


variable "rds_subnet_cidr_block2" {
  type = string
}
