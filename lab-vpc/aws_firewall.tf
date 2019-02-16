resource "aws_network_acl" "public_acl" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  subnet_ids = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}",
  ]
  tags {
    Name = "lab-architect-acl-public"
  }
}

resource "aws_network_acl" "private_acl" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  subnet_ids = [
    "${aws_subnet.private_subnet_a.id}",
    "${aws_subnet.private_subnet_b.id}",
  ]
  tags {
    Name = "lab-architect-acl-private"
  }
}
