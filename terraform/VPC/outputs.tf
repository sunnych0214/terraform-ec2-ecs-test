output "bastion-subnet-id" {
  value = element(aws_subnet.public.*.id, 0)
}

output "pub-subnet-ids" {
  value = aws_subnet.public.*.id
}

output "pri-subnet-ids" {
  value = aws_subnet.private.*.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}