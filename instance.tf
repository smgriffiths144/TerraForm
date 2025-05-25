resource "aws_s3_bucket_policy" "allow_access_from_account" {
  bucket = module.s3_bucket_remote_module.name
  policy = data.aws_iam_policy_document.allow_access_from_account.json
}

data "aws_iam_policy_document" "allow_access_from_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["022566422092"]
      #identifiers = ["arn:aws:iam::elb-022566422092:root"]
    }

    actions = [
      "s3:PutObject",
      "s3:ListBucket",
      "s3:*",
    ]

    resources = [
      module.s3_bucket_remote_module.arn,
      "${module.s3_bucket_remote_module.arn}/*",
    ]
  }
}


#trivy:ignore:AVD-AWS-0052 <- HERE
#trivy:ignore:AVD-AWS-0053 <- HERE
resource "aws_lb" "test" {
  name                       = "test-lb-tf-v2"
  internal                   = false
  load_balancer_type         = "application"
  drop_invalid_header_fields = true
  security_groups            = [aws_security_group.secure1.id]
  subnets                    = [aws_subnet.subnet1.id, aws_subnet.subnet3.id]
  xff_header_processing_mode = "preserve"
  /*
  access_logs {
    #bucket  = aws_s3_bucket.lb_logs.id
    bucket  = module.s3_bucket_remote_module.name
    prefix  = "test-lb"
    enabled = true
  }
*/
  tags = {
    Environment = "production"
    Terraform   = "true"
    Guff        = "stuff"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

#trivy:ignore:AVD-AWS-0054
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.webserevr.id
  port             = 80
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "web-ec2-profile"
  role = "AccountGuardian-SSMRole-DO-NOT-DELETE"
}

resource "aws_instance" "webserevr" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet2.id
  #key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.secure2.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  depends_on                  = [aws_internet_gateway.intgw]
  root_block_device {
    volume_type = "gp3"
    volume_size = 10
    encrypted   = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
  }
  user_data = file("./install_httpd.sh")
  tags = {
    Name    = "web-server000000000001"
    Guff    = "Stuff"
    Stuff   = "Stuff"
    Guffing = "Stuff"
    Ruff    = "Stuff"
  }
}

resource "aws_instance" "promgraf" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.subnet2.id
  #key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.secure2.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  depends_on                  = [aws_internet_gateway.intgw]
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    encrypted   = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
  }
  user_data = file("./install_promgraf.sh")
  tags = {
    Name = "prometheus and grafana"
    Guff = "Stuff"
    Butt = "Ruff"
  }
}

# Elastic IP for webserver
resource "aws_eip" "webserver_eip" {
  domain = "vpc"
  tags = {
    Name = "webserver-eip"
  }
}

# Associate Elastic IP with webserver instance
resource "aws_eip_association" "webserver_eip_assoc" {
  instance_id   = aws_instance.promgraf.id
  allocation_id = aws_eip.webserver_eip.id
}