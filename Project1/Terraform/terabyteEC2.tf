resource "aws_instance" "web1" {
  ami           = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  key_name      = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id = aws_subnet.private-subnet1.id

  tags = {
    Name = "terabyte-private1"
  }
}

resource "aws_instance" "web2" {
  ami           = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  key_name      = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id = aws_subnet.private-subnet2.id

  tags = {
    Name = "terabyte-private2"
  }
}

resource "aws_instance" "web3" {
  ami           = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  key_name      = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id = aws_subnet.private-subnet3.id

  tags = {
    Name = "terabyte-private3"
  }
}