# generating private key
resource "tls_private_key" "instance_keys" {
  count     = var.subnet_count
  algorithm = "RSA"
  rsa_bits  = 4096
}
# generating Key Pair
resource "aws_key_pair" "generated_keys" {
  count      = var.subnet_count
  key_name   = "Exam Machine ${count.index + 1}"
  public_key = tls_private_key.instance_keys[count.index].public_key_openssh
}
# save public key localy
resource "local_file" "private_key_files" {
  count           = var.subnet_count
  content         = tls_private_key.instance_keys[count.index].private_key_pem
  filename        = "Exam Machine ${count.index + 1}.pem"
  file_permission = "0400"
}
