resource "aws_security_group" "sg_web" {
  name = "ec2-sg"
  description = "sg for ec2"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "lab-architect-sg-web"
  }
}

resource "aws_network_acl" "acl_web" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  subnet_ids = [
    "${aws_subnet.public_subnet.id}",
  ]
  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
  }
  ingress {
    protocol = "tcp"
    rule_no = 110
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
  }
  ingress {
    protocol = "tcp"
    rule_no = 150
    cidr_block = "0.0.0.0/0"
    action = "allow"
    from_port = 32768
    to_port = 65535
  }
  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 32768
    to_port = 65535 
  }
  egress {
    protocol = "tcp"
    rule_no = 110
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80 
  }
  tags {
    Name = "lab-architect-acl-web"
  }
}
