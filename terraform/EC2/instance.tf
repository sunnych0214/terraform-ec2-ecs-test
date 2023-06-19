resource "aws_instance" "bastion" {
  ami = var.ami
  instance_type = var.instance-type
  subnet_id = var.bastion-subnet-id
  
  root_block_device {
    volume_size = var.volume-size
    volume_type = var.volume-type
    delete_on_termination = true
  }

  tags = {
    Name = "${var.project_name}-bastion"
  }
}