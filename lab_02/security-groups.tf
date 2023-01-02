resource "aws_security_group" "sg_webserver" {
  name        = "vpc-ssh"
  description = "Security group for webserver"

  # vpc_id = (default)

  ingress {
    description = "allow ssh from anywhere"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "author" = "imhshekhar47"
  }
}