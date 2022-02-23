provider "aws" {
  region = "ap-northeast-2"
}

module "main" {
  source = "../module"


  //vpc
  vpc_cidr_block             = "10.0.0.0/16"
  public_subnet_cidr_block1  = "10.0.0.0/24"
  public_subnet_cidr_block2  = "10.0.1.0/24"
  private_subnet_cidr_block1 = "10.0.2.0/24"
  private_subnet_cidr_block2 = "10.0.3.0/24"
  rds_subnet_cidr_block1     = "10.0.4.0/24"
  rds_subnet_cidr_block2     = "10.0.5.0/24"


  //bastion
  bastion_image_id      = "ami-0f66bf23ed74d9284"
  bastion_instance_type = "t2.micro"
  bastion_key_name      = "eworld-bastion"

/*
  //jenkins
  jenkins_image_id      = "ami-0f66bf23ed74d9284"
  jenkins_instance_type = "t2.micro"
  jenkins_key_name      = "eworld-jenkins"

*/

  //web (launch template > autoscaling)
  web_image_id      = "ami-0f66bf23ed74d9284"
  web_instance_type = "t2.micro"
  web_key_name      = "eworld-web"


  //api (launch template > autoscaling)
  api_image_id      = "ami-0f66bf23ed74d9284"
  api_instance_type = "t2.micro"
  api_key_name      = "eworld-api"


  //asg
  web_asg_capacity_desired = 2
  web_asg_capacity_max     = 10
  web_asg_capacity_min     = 2


  api_asg_capacity_desired = 2
  api_asg_capacity_max     = 10
  api_asg_capacity_min     = 2


  web_scale_up        = 2
  web_adjustment_type = "ChangeInCapacity"
  web_scale_down      = -1

  api_scale_up        = 2
  api_adjustment_type = "ChangeInCapacity"
  api_scale_down      = -1


  web_cpu_scaleup_threshold   = 60
  web_cpu_scaledown_threshold = 20
  api_cpu_scaleup_threshold   = 60
  api_cpu_scaledown_threshold = 20

/*
  //rds
  rds_instance_type = "db.t3.medium"
  identifier        = "eworld-mysql"
  engine            = "mysql"
  engine_version    = "5.7"
  allocated_storage = "30"
  multi_az          = false

  rds_username = "admin"
  rds_password = "Eworld123!"
*/
}
