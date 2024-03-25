resource "aws_instance" "bastion_instance" {
  count                  = length(var.pri_subnets_id)
  ami                    = var.image_id
  instance_type          = var.instance_type
  subnet_id              = var.pub_subnet_id
  vpc_security_group_ids = toset([var.bastion_ec2_sg[count.index]])
  key_name               = var.keyname
  tags = {
    Name = "bastion${count.index + 1}"
  }
}
