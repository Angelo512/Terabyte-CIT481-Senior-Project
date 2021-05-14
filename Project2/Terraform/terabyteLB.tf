# Create a new load balancer
resource "aws_elb" "bar" {
  name            = "terabyte-elb"
  security_groups = [aws_security_group.allow_http_ssh.id]
  subnets         = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id, aws_subnet.public-subnet3.id]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  #listener {
  # instance_port      = 443
  #instance_protocol  = "http"
  #lb_port            = 443
  #lb_protocol        = "https"
  #ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  #}

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }


  instances = [aws_spot_instance_request.spot1.spot_instance_id, aws_spot_instance_request.spot2.spot_instance_id, aws_spot_instance_request.spot3.spot_instance_id]

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400


}