output "instace_public_ip" {
  description = "Public IP address of the instance"
  value = aws_instance.exam_instance.public_ip
}