output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "pub-sub-01-id" {
  value = aws_subnet.my_subnet[0].id
}

output "pri-dev-sub-01-id" {
  value = aws_subnet.my_subnet[1].id
}

output "pri-dev-sub-02-id" {
  value = aws_subnet.my_subnet[2].id
}

output "pri-db-sub-02-id" {
  value = aws_subnet.my_subnet[3].id
}
