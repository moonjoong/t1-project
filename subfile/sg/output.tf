output "bastion_sg_id_01" {
  value = aws_security_group.bastion_sg[0].id
}

output "bastion_sg_id_02" {
  value = aws_security_group.bastion_sg[1].id
}
output "pri_sg_id_01" {
  value = aws_security_group.pri_sg[0].id
}

output "pri_sg_id_02" {
  value = aws_security_group.pri_sg[1].id
}
