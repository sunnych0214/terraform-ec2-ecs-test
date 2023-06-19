module "VPC" {
  source = "./VPC"
  
  project_name = var.project_name

  cidr = local.vpc_config.cidr
  public_subnets = local.vpc_config.public_subnets
  private_subnets = local.vpc_config.private_subnets
  availability_zone = var.availability_zone
}

module "EC2" {
  source = "./EC2"

  project_name = var.project_name

  ami = local.ec2_config.ami
  instance-type = local.ec2_config.instance_type
  volume-size = local.ecimage.png2_config.volume_size
  volume-type = local.ec2_config.volume_type
  bastion-subnet-id = module.VPC.bastion-subnet-id
}

module "ECS" {
  source = "./ECS"

  project_name = var.project_name
  aws_region = var.aws_region
  app_image = local.ecs_config.app_image
  app_port = local.ecs_config.app_port
  pri_subnet_ids = module.VPC.pri-subnet-ids
  pub_subnet_ids = module.VPC.pub-subnet-ids
  vpc_id = module.VPC.vpc_id
}