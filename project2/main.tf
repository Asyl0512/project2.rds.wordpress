provider "aws" {
  region = var.region
}

module "wordpress" {
  source           = "./modules/wordpress"
  region           = var.region
  vpc_cidr         = var.vpc_cidr
  subnets          = var.subnets
  instance_type    = var.instance_type
  ami              = var.ami
  database_details = var.database_details
}
