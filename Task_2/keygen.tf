# generating private key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# generating Key Pair
resource "aws_key_pair" "public_key" {
  key_name   = "Key"
  public_key = tls_private_key.private_key.public_key_openssh
}
# save private key locally
resource "local_file" "private_key_files" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "Key.pem"
  file_permission = "0400"
}
