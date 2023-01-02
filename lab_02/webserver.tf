data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"

  key_name               = aws_key_pair.key_pair.key_name
  user_data              = file("${path.module}/boot.sh")
  vpc_security_group_ids = [aws_security_group.sg_webserver.id]

  tags = {
    Name   = "webserver"
    author = "imhshekhar47"
  }
}

output "webserver_ip" {
  description = "Public ip of webserver"
  value       = aws_instance.webserver.public_ip
}