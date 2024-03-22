variable "image_id" {
  type    = string
  default = "ami-02b668243e1aba105"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "pri_subnets_id" {
  type = list(string)

}

variable "ansible_ec2_sg" {
  type = list(string)
}
variable "node_ec2_sg" {
  type = any
}

variable "keyname" {
  type = string
}
# variable "subnet_id" {
#   type = string

# }
