variable "project_name" {
  description = "project name"
  type = string
}

variable "ami" { 
  type = string 
}

variable "instance-type" {
  type = string 
}

variable "volume-size" { 
  type = string 
}

variable "volume-type" { 
  type = string
}

variable "bastion-subnet-id" {
  type = string
}