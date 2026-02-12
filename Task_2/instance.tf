resource "aws_instance" "exam_instance" {
  ami = "ami-0801976e993cd4ddf"
  # TODO: to change back to t2.micro
  instance_type               = "t3.micro"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.exam_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.public_key.key_name
  associate_public_ip_address = true
  tags = {
    "Name"    = "Exam Machine"
    "Created" = "Terraform"
  }
  depends_on = [aws_subnet.public_subnet, aws_security_group.exam_sg]
}
