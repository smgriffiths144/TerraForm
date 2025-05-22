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
  map_public_ip_on_launch = "false"
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
  map_public_ip_on_launch = "false"
  tags = {
    Name        = "subnet1"
    Terraform   = "True"
    Environment = "dev33334444"
  }
}
#trivy:ignore:aws-vpc-no-public-ingress-sgr <- HERE
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

# CloudWatch Log Group for VPC Flow Logs
resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aws/vpc-flow-log/${aws_vpc.main.id}"
  retention_in_days = 30
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for VPC Flow Logs
resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  name = "vpc-flow-log-policy"
  role = aws_iam_role.vpc_flow_log_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# VPC Flow Log
resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

