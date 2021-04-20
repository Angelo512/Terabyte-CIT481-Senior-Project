resource "aws_instance" "bastion" {
  ami           = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  key_name      = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  tags = {
    Name = "terabyte-bastion"
  }
}