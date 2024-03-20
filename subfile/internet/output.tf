output "pub-route-table-id" {
  value = aws_route_table.route_table[0].id
}

output "pri-route-table-id" {
  value = aws_route_table.route_table[1].id
}

output "igw-id" {
  value = aws_internet_gateway.igw.id
}

output "nat-id" {
  value = aws_nat_gateway.nat_gateway_1.id
}
