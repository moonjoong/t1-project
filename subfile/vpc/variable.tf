variable "region" {
  type    = string
  default = "ap-east-1"
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pub_cidr_sub" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "pri_ec2_cidr_sub" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.30.0/24"]
}

variable "pri_db_cidr_sub" {
  type    = list(string)
  default = ["10.0.20.0/24"]

}
variable "az" {
  type    = string
  default = "ap-east-1a"
}

variable "public_ip" {
  default = "false"
}
