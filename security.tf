
resource "aws_security_group" "secure1" {
  name        = "secure1"
  vpc_id      = aws_vpc.main.id
  description = "security group for the ALB"
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  tags = {
    Name = "WBDMZ"
  }
}
resource "aws_security_group" "secure2" {
  name        = "secure2"
  vpc_id      = aws_vpc.main.id
  description = "secuirty group for the web server"
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = [aws_subnet.subnet1.cidr_block]
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["82.39.120.159/32"]
  }
#trivy:ignore:aws-vpc-no-public-egress-sgr <- HERE
  egress {
    description = "outound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DATABASE"
  }
}