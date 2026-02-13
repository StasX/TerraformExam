output "instances_public_ip" {
  value       = aws_instance.exam_instance[*].public_ip
}
