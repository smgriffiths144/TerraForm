resource "aws_vpc" "main" {
  cidr_block       = "10.24.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name        = "jjdksjgjfgjfdgdj"
    Terraform   = "truehhhhh"
    Environment = "dev33333888888"
  }
}

resource "aws_route_table" "routetable1" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "route1" {
  route_table_id         = aws_route_table.routetable1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.intgw.id
}

resource "aws_route_table_association" "routetableassoc1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.routetable1.id
}

resource "aws_route_table" "routetable2" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "route2" {
  route_table_id         = aws_route_table.routetable2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.intgw.id
  #instance_id= aws_instance.wordpress.id
}

resource "aws_route_table_association" "routetableassoc2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.routetable2.id
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.24.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet1"
    Terraform   = "True"
    Environment = "dev33334444"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.24.3.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet1"
    Terraform   = "True"
    Environment = "dev33334444"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.24.2.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet2"
    Terraform   = "True"
    Environment = "dev"
  }
}

resource "aws_internet_gateway" "intgw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "mainIGW"
    Terraform   = "true"
    Environment = "dev"
  }
}

