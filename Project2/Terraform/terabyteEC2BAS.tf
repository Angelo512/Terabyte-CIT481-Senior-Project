resource "aws_spot_instance_request" "bastion" {
  ami                         = "ami-02701bcdc5509e57b"
  spot_price                  = "0.016"
  instance_type               = "t2.micro"
  spot_type                   = "one-time"
  wait_for_fulfillment        = "true"
  key_name                    = "cit481_terabyte0"
  vpc_security_group_ids      = [aws_security_group.allow_http_ssh.id]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  tags = {
    Name = "terabyte-spot-bastion"
  }
}
