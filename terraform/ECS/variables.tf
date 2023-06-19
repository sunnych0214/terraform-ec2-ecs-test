variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "app_image" {
  type = string
}

variable "app_port" {
  type = number
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "fargate_cpu" {
  type = number
  default = 256
}

variable "fargate_memory" {
  type = number
  default = 512
}

variable "desired_count" {
  type = number
  default = 3
}

variable "pri_subnet_ids" { 
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "pub_subnet_ids" {
  type = list(string)
}

variable "health_check_path" {
  default = "/"
}