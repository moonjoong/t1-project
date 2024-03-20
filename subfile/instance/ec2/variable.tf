# variable "num" {
#   type    = number
#   default = 1
# }

variable "image_id" {
  type    = string
  default = "ami-02b668243e1aba105"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "subnets_id" {
  type = list(string)

}

variable "pub_sub_sg" {
  type = set(string)
}
