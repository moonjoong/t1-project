output "bastion_sg_id" {
  value = aws_security_group.bastion_sg[*].id
}

output "ansible_sg_id" {
  value = aws_security_group.ansible_sg[*].id
}

output "node_sg_id" {
  value = aws_security_group.node_sg[*].id
}
