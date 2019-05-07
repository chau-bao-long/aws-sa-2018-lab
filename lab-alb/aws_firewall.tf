resource "aws_security_group" "sg_alb" {
  name = "lab-architect-sg-alb"
  description = "sg for alb"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "lab-architect-sg-alb"
  }
}

resource "aws_security_group" "sg_ec2" {
  name = "lab-architect-sg-ec2"
  description = "sg for ec2"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [
      "${aws_security_group.sg_alb.id}"
    ]
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
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "lab-architect-sg-ec2"
  }
}

resource "aws_network_acl" "acl_web" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  subnet_ids = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}",
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
