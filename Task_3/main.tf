
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.region
}

module "vpc_n_ec2" {
  source           = "./modules/vpc_n_ec2"
  vpc_cidr         = "10.0.0.0/16"
  subnet_count     = 5
  instance_type    = "t3.micro"
  assign_public_ip = true
}
