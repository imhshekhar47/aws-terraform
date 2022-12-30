resource "aws_instance" "webserver" {
  ami           = "ami-0ceecbb0f30a902a6"
  instance_type = "t2.micro"

  user_data = file("${path.module}/boot.sh")

  tags = {
    Name  = "webserver"
    owner = "imhshekhar47"
  }
}

output "webserver_ip" {
  description = "Public ip of webserver"
  value       = aws_instance.webserver.public_ip
}