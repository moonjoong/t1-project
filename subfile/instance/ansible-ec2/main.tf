

resource "aws_instance" "ansible_instance" {
  count                  = length(var.pri_subnets_id)
  ami                    = var.image_id                    # 사용할 AMI ID를 지정합니다.
  instance_type          = var.instance_type               # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
  subnet_id              = var.pri_subnets_id[count.index] # 위에서 생성한 서브넷의 ID를 사용합니다.
  vpc_security_group_ids = toset([var.ansible_ec2_sg[count.index]])
  key_name               = "moonkey"
  tags = {
    Name = "ansible-server${count.index + 1}"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo amazon-linux-extras install epel -y 
  sudo amazon-linux-extras enable ansible2
  sudo yum install -y ansible
  EOF

}

# resource "aws_instance" "node_instance" {
#   for {

#   }
#   ami           = var.image_id      # 사용할 AMI ID를 지정합니다.
#   instance_type = var.instance_type # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
#   subnet_id     = var.subnet_id     # 위에서 생성한 서브넷의 ID를 사용합니다.
# }

resource "aws_instance" "node_instance" {
  count         = length(var.pri_subnets_id) * 3 # 총 인스턴스 수를 계산합니다.
  ami           = var.image_id                   # 사용할 AMI ID를 지정합니다.
  instance_type = var.instance_type              # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
  subnet_id     = element(var.pri_subnets_id, floor(count.index / 3))
  key_name      = "moonkey"
  # vpc_security_group_ids = toset(element(var.node_ec2_sg, floor(count.index / 3)))
  # # vpc_security_group_ids = count.index == 
  tags = {
    Name = "ansible${floor(count.index / 3 + 1)}-node${(count.index % 3 + 1)}"
  }
}
