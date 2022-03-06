
variable "rds_instance_type" {
  type = string
}

variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "allocated_storage" {
  type = string
}

variable "max_allocated_storage" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}
