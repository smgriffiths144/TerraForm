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



resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secure1.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet3.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]

  #enable_deletion_protection = true
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
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

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
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
  }
  user_data = file("./install_httpd.sh")
  tags = {
    Name = "web server"
    Guff = "Stuff"
  }
}
/*
resource "aws_instance" "mysql" {
  ami                         = "ami-0f88e80871fd81e91"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet1.id
  #key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.secure2.id]
  associate_public_ip_address = true
  user_data                   = file("install_mysql.sh")
  tags = {
    Name = "Mysql-bv-v5"
  }
}
*/
