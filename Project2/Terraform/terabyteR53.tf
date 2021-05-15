
resource "aws_route53_zone" "main" {
  name = "terabytecit.com"
}

resource "aws_route53_record" "main-A" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "terabytecit.com"
  type    = "A"
  
    alias {
    name                   = aws_elb.bar.dns_name
    zone_id                = aws_elb.bar.zone_id
    evaluate_target_health = true
  }
}
