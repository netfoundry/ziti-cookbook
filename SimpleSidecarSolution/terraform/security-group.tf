// Zero Ingress SG for ECS Service

resource "aws_security_group" "zero_ingress" {
  name        = "zero_ingress"
  description = "Allow no inbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "zero_ingress"
  }
}