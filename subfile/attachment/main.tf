resource "aws_route_table_association" "route_table_association_public" {
  subnet_id      = var.pub_subnet_id
  route_table_id = var.pub_route_table_id
}

resource "aws_route_table_association" "route_table_association_private" {
  count          = length(var.pri_subnets_id)
  subnet_id      = var.pri_subnets_id[count.index]
  route_table_id = var.pri_route_table_id
}


