resource "aws_spot_instance_request" "spot1" {
  ami                    = "ami-02701bcdc5509e57b"
  spot_price             = "0.016"
  instance_type          = "t2.micro"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.priv_allow_http_ssh.id]
  subnet_id              = aws_subnet.private-subnet1.id

  tags = {
    Name = "terabyte-spot-private1"
  }
}

resource "aws_spot_instance_request" "spot2" {
  ami                    = "ami-02701bcdc5509e57b"
  spot_price             = "0.016"
  instance_type          = "t2.micro"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.priv_allow_http_ssh.id] 
  subnet_id              = aws_subnet.private-subnet2.id

  tags = {
    Name = "terabyte-spot-private2"
  }
}

resource "aws_spot_instance_request" "spot3" {
  ami                    = "ami-02701bcdc5509e57b"
  spot_price             = "0.016"
  instance_type          = "t2.micro"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = "cit481_terabyte0"
  vpc_security_group_ids = [aws_security_group.priv_allow_http_ssh.id]
  subnet_id              = aws_subnet.private-subnet3.id

  tags = {
    Name = "terabyte-spot-private3"
  }
}

