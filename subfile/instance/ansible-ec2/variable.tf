variable "image_id" {
  type    = string
  default = "ami-02b668243e1aba105"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnets_id" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.30.0/24"]
}

variable "pri_sub_sg" {
  type = list(string)
}

# variable "subnet_id" {
#   type = string

# }
