variable "region" {
  type    = string
  default = "ap-east-1"
}

variable "image_id" {
  type    = string
  default = "ami-02b668243e1aba105"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "pub_cidr_sub" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "pri_ec2_cidr_sub" {
  type    = list(string)
  default = ["10.0.10.0/24"]
}

variable "pri_db_cidr_sub" {
  type    = list(string)
  default = ["10.0.20.0/24"]
}

variable "local_cidr_block" {
  type    = string
  default = "61.85.118.29/32"
}

variable "pem_key" {
  type    = string
  default = "moonkey"
}

variable "num" {
  type    = number
  default = 2
}
