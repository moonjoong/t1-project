variable "num" {
  type    = number
  default = 2
}

variable "image_id" {
  type    = string
  default = "ami-02b668243e1aba105"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "subnet_id" {
  type = string

}

variable "pub_sub_sg" {
  type = list(string)
}
