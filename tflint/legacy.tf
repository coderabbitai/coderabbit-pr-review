resource "aws_eip" "Web" {
  count    = length(var.subnets) > 0 ? 1 : 0
  instance = "${aws_instance.MyInstance.id}"
  domain   = "vpc"
}

resource "aws_route53_record" "Apex" {
  count   = var.subnets == [] ? 0 : 1
  zone_id = "Z123456ABCDEFG"
  name    = "demoapp.example.com"
  type    = "A"
  ttl     = 60
  records = ["${aws_eip.Web.*.public_ip[0]}"]
}

resource "aws_security_group_rule" "AllowSsh" {
  count             = "${length(var.subnets)}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_instance.MyInstance.vpc_security_group_ids[0]}"
}

locals {
  primary_region = "${var.region}"
  environment    = "${var.environment}"
}

output "first_subnet" {
  value = "${var.subnets[0]}"
}

output "primary_eip" {
  value = "${aws_eip.Web.*.public_ip[0]}"
}
