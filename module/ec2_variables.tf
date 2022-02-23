variable "bastion_image_id" {
  type = string
}

/*
variable "jenkins_image_id" {
  type = string
}
*/

variable "web_image_id" {
  type = string
}

variable "api_image_id" {
  type = string
}


variable "bastion_instance_type" {
  type = string
}
/*
variable "jenkins_instance_type" {
  type = string
}
*/
variable "web_instance_type" {
  type = string
}

variable "api_instance_type" {
  type = string
}

variable "bastion_key_name" {
  type = string
}
/*
variable "jenkins_key_name" {
  type = string
}
*/
variable "web_key_name" {
  type = string
}

variable "api_key_name" {
  type = string
}

//terraform 에서 integer에 해당하는 variable type은 number이다
variable "web_asg_capacity_desired" {
  type = number
}

variable "web_asg_capacity_max" {
  type = number
}

variable "web_asg_capacity_min" {
  type = number
}

variable "api_asg_capacity_desired" {
  type = number
}

variable "api_asg_capacity_max" {
  type = number
}

variable "api_asg_capacity_min" {
  type = number
}

variable "web_scale_up" {
  type = number
}

variable "web_scale_down" {
  type = number
}

variable "web_adjustment_type" {
  type = string
}

variable "api_scale_up" {
  type = number
}

variable "api_scale_down" {
  type = number
}

variable "api_adjustment_type" {
  type = string
}

variable "web_cpu_scaleup_threshold" {
  type = number
}

variable "web_cpu_scaledown_threshold" {
  type = number
}

variable "api_cpu_scaleup_threshold" {
  type = number
}

variable "api_cpu_scaledown_threshold" {
  type = number
}
