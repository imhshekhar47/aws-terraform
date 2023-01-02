resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key_file" {
  content         = tls_private_key.rsa_key.private_key_pem
  filename        = "key-file.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "ec2-key-pair"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

output "key_name" {
  description = "Key pair name"
  value       = aws_key_pair.key_pair.key_name
}