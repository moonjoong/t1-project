resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_vpc

}

resource "aws_subnet" "pub_subnet" {
  count                   = length(var.pub_cidr_sub)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub_cidr_sub[count.index]
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_sub_${count.index + 1}"
  }
}

resource "aws_subnet" "pri_ec2_subnet" {
  count             = length(var.pri_ec2_cidr_sub)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.pri_ec2_cidr_sub[count.index]
  availability_zone = var.az
  tags = {
    Name = "pri_ec2_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "pri_db_subnet" {
  count             = length(var.pri_db_cidr_sub)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.pri_db_cidr_sub[count.index]
  availability_zone = var.az
  tags = {
    Name = "pri_db_subnet_${count.index + 1}"
  }
}
