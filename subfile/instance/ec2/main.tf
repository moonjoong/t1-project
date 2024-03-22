resource "aws_instance" "bastion_instance" {
  count                  = length(var.pri_subnets_id)
  ami                    = var.image_id      # 사용할 AMI ID를 지정합니다.
  instance_type          = var.instance_type # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
  subnet_id              = var.pub_subnet_id
  vpc_security_group_ids = toset([var.bastion_ec2_sg[count.index]])
  key_name               = var.keyname
  tags = {
    Name = "bastion${count.index + 1}"
  }
}
