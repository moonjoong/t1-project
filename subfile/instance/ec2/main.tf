resource "aws_instance" "bastion_instance" {
  count                  = length(var.subnets_id)
  ami                    = var.image_id                # 사용할 AMI ID를 지정합니다.
  instance_type          = var.instance_type           # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
  subnet_id              = var.subnets_id[count.index] # 위에서 생성한 서브넷의 ID를 사용합니다.
  vpc_security_group_ids = var.pub_sub_sg
}
