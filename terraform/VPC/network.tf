# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
     Name = "${var.project_name}-vpc"
    }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.public_subnets)
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-pub-sbt-${count.index + 1}"
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.private_subnets)
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "${var.project_name}-pri-sbt-${count.index + 1}"
  }
}

# igw, NAT gw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = element(aws_subnet.public.*.id, 1)
  depends_on = [ aws_eip.nat-eip, aws_subnet.public ]
  tags = {
    Name = "${var.project_name}-nat"
  }
}
resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-rt-pub"
  }
}
resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  count = length(var.public_subnets)
  subnet_id = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name}-rt-pri"
  }
}
resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  count = length(var.private_subnets)
  subnet_id = element(aws_subnet.private.*.id, count.index)
}