resource "aws_instance" "exam_instance" {
  count                       = var.subnet_count
  ami                         = var.ami_type
  instance_type               = var.instance_type
  availability_zone           = aws_subnet.subnets[count.index].availability_zone
  vpc_security_group_ids      = [aws_security_group.exam_sg.id]
  subnet_id                   = aws_subnet.subnets[count.index].id
  associate_public_ip_address = var.assign_public_ip
  key_name                    = aws_key_pair.generated_keys[count.index].key_name
  tags = {
    "Name"    = "Exam Machine ${count.index + 1}"
    "Created" = "Terraform"
  }
  depends_on = [aws_subnet.subnets, aws_security_group.exam_sg, aws_key_pair.generated_keys]
}
