output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "pub-sub-01-id" {
  value = aws_subnet.pub_subnet[0].id
}

output "pri-dev-sub-01-id" {
  value = aws_subnet.pri_subnet[0].id
}

output "pri-dev-sub-02-id" {
  value = aws_subnet.pri_subnet[1].id
}

output "pri-db-sub-01-id" {
  value = aws_subnet.pri_subnet[2].id
}
