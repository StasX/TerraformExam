output "instace_public_ip" {
  description = "Public IP address of the instance"
  value       = module.vpc_n_ec2.instance_public_ip
}
