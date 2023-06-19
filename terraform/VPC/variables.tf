variable "project_name" {
  description = "project name"
  type = string
}


variable "cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}