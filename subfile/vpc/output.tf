output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "pub_sub_id" {
  value = aws_subnet.pub_subnet[*].id
}

output "pri_ec2_sub_id" {
  value = aws_subnet.pri_ec2_subnet[*].id
}
