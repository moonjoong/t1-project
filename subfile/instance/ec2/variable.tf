variable "num" {
  type = number
}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "pub_subnet_id" {
  type = string
}

variable "bastion_ec2_sg" {
  type = list(string)
}

variable "keyname" {
  type = string
}

variable "pri_subnets_id" {
  type = list(string)
}
