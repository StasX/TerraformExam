module "vpc_n_ec2" {
  source           = "./modules/vpc_n_ec2"
  vpc_cidr         = "10.0.0.0/16"
  subnet_count     = 2
  instance_type    = "t3.micro"
  assign_public_ip = true
  region           = var.region
}
