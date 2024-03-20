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
  source       = "./subfile/vpc"
  pri_cidr_sub = var.pri_cidr_sub
  pub_cidr_sub = var.pub_cidr_sub
  region       = var.region

}



module "internet" {
  source = "./subfile/internet"
  num    = 2
  vpc_id = module.vpc.vpc_id
  # subnets_id = [module.vpc.pub-sub-01-id, module.vpc.pri-dev-sub-01-id, module.vpc.pri-dev-sub-02-id]
  pub_subnet_id = module.vpc.pub-sub-01-id

}

# module "sg" {
#   source             = "./subfile/attachment"
#   pub_subnet_id      = module.vpc.pub-sub-01-id
#   pri_subnets_id     = [module.vpc.pri-dev-sub-01-id, module.vpc.pri-dev-sub-02-id, module.vpc.pri-db-sub-01-id]
#   pub_route_table_id = module.internet.pub-route-table-id
#   pri_route_table_id = module.internet.pri-route-table-id
# }

module "att" {
  source             = "./subfile/attachment"
  pub_subnet_id      = module.vpc.pub-sub-01-id
  pri_subnets_id     = [module.vpc.pri-dev-sub-01-id, module.vpc.pri-dev-sub-02-id, module.vpc.pri-db-sub-01-id]
  pub_route_table_id = module.internet.pub-route-table-id
  pri_route_table_id = module.internet.pri-route-table-id
  igw_id             = module.internet.igw-id
}

module "sg" {
  source             = "./subfile/sg"
  vpc_id             = module.vpc.vpc_id
  local_cidr_block   = "100.0.0.0/24"
  pri_sub_cidr_block = [module.vpc.pri-dev-sub-01-id, module.vpc.pri-dev-sub-02-id]

}

module "bastion-ec2" {
  source     = "./subfile/instance/ec2"
  subnets_id = [module.vpc.pub-sub-01-id]
  pub_sub_sg = [module.sg.bastion_sg_id_01, module.sg.pri_sg_id_02]

}
module "pri-ansible-server" {
  source     = "./subfile/instance/ansible-ec2"
  subnets_id = [module.vpc.pri-dev-sub-01-id, module.vpc.pri-dev-sub-02-id]
  pri_sub_sg = [module.sg.pri_sg_id_01, module.sg.pri_sg_id_02]

}
