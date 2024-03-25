output "node_ip" {
  value = aws_instance.node_instance[*].private_ip
}
