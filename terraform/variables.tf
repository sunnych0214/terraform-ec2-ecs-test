# common
variable "project_name" {
  description = "project name"
  type = string
  default = "sun-test"
}

variable "availability_zone" {
  description = "availability_zone"
  type = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "aws_region" {
  description = "aws region"
  type = string
  default = "ap-northeast-2"
}

locals {
  vpc_config = {
    cidr : "10.0.0.0/16"
    public_subnets : ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnets : ["10.0.2.0/24", "10.0.3.0/24"]
  }

  ec2_config = {
    ami : "ami-027886247d2f15359"
    instance_type : "t2.micro"
    volume_size : "8"
    volume_type : "gp3"
  }

  ecs_config = {
    app_image : "bradfordhamilton/crystal_blockchain:latest"
    app_port : 80
  }
}