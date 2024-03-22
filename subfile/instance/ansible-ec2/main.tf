data "aws_iam_policy_document" "s3_read_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::moonjoong/moonkey.pem"] # 읽을 수 있는 버킷 및 객체의 ARN을 지정합니다.
  }
}

resource "aws_iam_policy" "s3_read_access_policy" {
  name        = "s3-read-access-policy"
  description = "Policy to allow reading objects from specific S3 bucket"
  policy      = data.aws_iam_policy_document.s3_read_policy.json
}

resource "aws_iam_role" "s3_read_role" {
  name = "s3-read-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : { "Service" : "ec2.amazonaws.com" },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_read_access_attachment" {
  role       = aws_iam_role.s3_read_role.name
  policy_arn = aws_iam_policy.s3_read_access_policy.arn
}

resource "aws_iam_instance_profile" "s3_read_instance_profile" {
  count = length(var.pri_subnets_id)
  name  = "s3-read-instance-profile-${count.index}"
  role  = aws_iam_role.s3_read_role.name
}


resource "aws_instance" "ansible_instance" {
  count                  = length(var.pri_subnets_id)
  ami                    = var.image_id                    # 사용할 AMI ID를 지정합니다.
  instance_type          = var.instance_type               # 인스턴스 유형을 지정합니다. 필요에 따라 변경하세요.
  subnet_id              = var.pri_subnets_id[count.index] # 위에서 생성한 서브넷의 ID를 사용합니다.
  vpc_security_group_ids = toset([var.ansible_ec2_sg[count.index]])
  key_name               = var.keyname
  tags = {
    Name = "ansible-server${count.index + 1}"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo amazon-linux-extras install epel -y 
  sudo amazon-linux-extras enable ansible2
  sudo yum install -y ansible
  aws s3 cp s3://moonjong/moonkey.pem /home/ec2-user/moonkey.pem
  touch inventory_file
  touch ansible.cfg
  echo "[defaults]" >> ansible.cfg
  echo "private_key_file = /home/ec2-user/moonkey.pem" >> ansible.cfg
  echo "inventory = /home/ec2-user/inventory_file" >> ansible.cfg
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
  key_name      = var.keyname
  vpc_security_group_ids = toset([
    element(var.node_ec2_sg, floor(count.index / 3))
  ])

  # vpc_security_group_ids = toset(element(var.node_ec2_sg, floor(count.index / 3)))
  # # vpc_security_group_ids = count.index == 
  tags = {
    Name = "ansible${floor(count.index / 3 + 1)}-node${(count.index % 3 + 1)}"
  }
}
