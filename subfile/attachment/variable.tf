variable "pub_subnet_id" {
  type = string
}

variable "pri_subnets_id" {
  type = list(string)
}

variable "pub_route_table_id" {
  type = string
}

variable "pri_route_table_id" {
  type = string
}

variable "igw_id" {
  type = string
}
