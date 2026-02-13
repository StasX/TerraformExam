resource "aws_instance" "exam_instance" {
  ami = "ami-0801976e993cd4ddf"
  instance_type               = "t2.micro"
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [aws_security_group.exam_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.public_key.key_name
  associate_public_ip_address = true
  tags = {
    "Name"    = "Exam Machine"
    "Created" = "Terraform"
  }
  depends_on = [aws_subnet.public_subnet, aws_security_group.exam_sg, aws_key_pair.public_key]
}
