terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.1"
    }
  }
  required_version = ">= 1.7.1"
}

provider "aws" {
  region = var.region

}

module "vpc" {
  source           = "./subfile/vpc"
  pri_ec2_cidr_sub = var.pri_ec2_cidr_sub
  pri_db_cidr_sub  = var.pri_db_cidr_sub
  pub_cidr_sub     = var.pub_cidr_sub
  region           = var.region

}

module "internet" {
  source        = "./subfile/internet"
  num           = 2
  vpc_id        = module.vpc.vpc_id
  pub_subnet_id = module.vpc.pub_sub_id[0]

}

module "att" {
  source             = "./subfile/attachment"
  pub_subnet_id      = module.vpc.pub_sub_id[0]
  pri_subnets_id     = module.vpc.pri_ec2_sub_id[*]
  pub_route_table_id = module.internet.pub-route-table-id
  pri_route_table_id = module.internet.pri-route-table-id
  igw_id             = module.internet.igw-id
}

module "sg" {
  source           = "./subfile/sg"
  vpc_id           = module.vpc.vpc_id
  local_cidr_block = "61.85.118.29/32"
  pri_subnets_id   = module.vpc.pri_ec2_sub_id[*]

}

module "bastion-ec2" {
  source         = "./subfile/instance/ec2"
  pub_subnet_id  = module.vpc.pub_sub_id[0]
  bastion_ec2_sg = module.sg.bastion_sg_id[*]
  pri_subnets_id = module.vpc.pri_ec2_sub_id[*]
  keyname        = "moonkey"
  image_id       = "ami-02b668243e1aba105"
  instance_type  = "t3.micro"

}

module "pri-ansible-server" {
  source         = "./subfile/instance/ansible-ec2"
  pri_subnets_id = module.vpc.pri_ec2_sub_id[*]
  ansible_ec2_sg = module.sg.ansible_sg_id[*]
  node_ec2_sg    = module.sg.node_sg_id
  keyname        = "moonkey"
  image_id       = "ami-02b668243e1aba105"
  instance_type  = "t3.micro"
}

