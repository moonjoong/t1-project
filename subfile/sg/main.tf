resource "aws_security_group" "bastion_sg" {
  count  = length(var.pri_sub_cidr_block)
  vpc_id = var.vpc_id
  name   = "bastion-security-group-${count.index + 1}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.local_cidr_block}"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "pri_sg" {
  count  = length(var.pri_sub_cidr_block)
  vpc_id = var.vpc_id
  name   = "pri-security-group-${count.index + 1}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    # cidr_blocks = ["${var.bastion_cidr_block[count.index]}"]
    security_groups = [aws_security_group.bastion_sg[count.index].id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


