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
  source   = "./subfile/vpc"
  cidr_sub = ["10.0.1.0/24", "10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  region   = var.region

}
module "bastion-ec2" {
  source    = "./subfile/instance"
  subnet_id = module.vpc.pub-sub-01-id

}
module "pri-01-ec2" {
  count     = 3
  source    = "./subfile/instance"
  subnet_id = module.vpc.pri-dev-sub-01-id

}

module "pri-02-ec2" {
  count     = 3
  source    = "./subfile/instance"
  subnet_id = module.vpc.pri-dev-sub-02-id

}
