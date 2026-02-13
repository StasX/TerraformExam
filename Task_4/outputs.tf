output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = module.vpc_n_ec2.instance_public_ip
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.exam_alb.dns_name
}
