variable "region" {
  type    = string
  default = "ap-east-1"
}
variable "vpc_id" {
  type = string
}
variable "cidr" {
  type = list(string)
  default = [
    "10.0.0.0/16", "10.0.1.0/24", "10.0.10.0/24", "10.0.30.0/24", "10.0.20.0/24"

  ]

}

