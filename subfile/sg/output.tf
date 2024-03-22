# output "bastion_sg_id_01" {
#   value = aws_security_group.bastion_sg[0].id
# }

# output "bastion_sg_id_02" {
#   value = aws_security_group.bastion_sg[1].id
# }
# output "ansible_sg_id_01" {
#   value = aws_security_group.ansible_sg[0].id
# }

# output "ansible_sg_id_02" {
#   value = aws_security_group.ansible_sg[1].id
# }

# output "node_sg_id_01" {
#   value = aws_security_group.node_sg[0].id
# }

# output "node_sg_id_02" {
#   value = aws_security_group.node_sg[1].id
# }
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg[*].id
}

output "ansible_sg_id" {
  value = aws_security_group.ansible_sg[*].id
}

output "node_sg_id" {
  value = aws_security_group.node_sg[*].id
}
