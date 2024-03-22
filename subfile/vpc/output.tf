output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "pub_sub_id" {
  value = aws_subnet.pub_subnet[*].id
}

output "pri_sub_id" {
  value = aws_subnet.pri_subnet[*].id
}
