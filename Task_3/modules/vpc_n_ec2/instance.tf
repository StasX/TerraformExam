resource "aws_instance" "exam_instance" {
  ami                         = "ami-0801976e993cd4ddf"
  instance_type               = var.instance_type
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [aws_security_group.exam_sg.id]
  subnet_id                   = aws_subnet.subnets[0].id
  key_name                    = aws_key_pair.public_key.key_name
  associate_public_ip_address = var.assign_public_ip
  tags = {
    "Name"    = "Exam Machine"
    "Created" = "Terraform"
  }
  depends_on = [aws_subnet.subnets, aws_security_group.exam_sg]
}
