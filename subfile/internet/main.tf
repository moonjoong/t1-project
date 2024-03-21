resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_table" {
  count  = var.num
  vpc_id = var.vpc_id
  tags = {
    Name = "rt.${count.index}"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = count.index == 0 ? aws_internet_gateway.igw.id : null
    nat_gateway_id = count.index == 1 ? aws_nat_gateway.nat_gateway_1.id : null
  }
}



resource "aws_eip" "nat_1" {
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "nat_1"
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {

  allocation_id = aws_eip.nat_1.allocation_id
  subnet_id     = var.pub_subnet_id
  tags = {
    Name = "NAT-GW-1"
  }
}
