resource "aws_instance" "wordpress" {
  ami                         = "ami-0f88e80871fd81e91"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet1.id
  #key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.secure1.id]
  associate_public_ip_address = true
  depends_on                  = [aws_internet_gateway.intgw]
  user_data                   = file("install_wordpress.sh")
  tags = {
    Name = "Wordpress-v4"
    Guff = "Stuff"
  }
}

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