output "instace_public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.exam_instance[*].public_ip
}
output "vpc_id" {
  description = "Public IP address of the instance"
  value       = aws_vpc.exam_vpc.id
}
output "subnets" {
  value = aws_subnet.subnets[*].id
}
output "instances_ids" {
  value = aws_instance.exam_instance[*].id 
}
output "exam_sg" {
  value = aws_security_group.exam_sg.id
}