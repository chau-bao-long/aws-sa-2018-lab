resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_main_igw.id}"
  }
  tags {
    Name = "lab-architect-route-public"
  }
}

resource "aws_default_route_table" "main_rt" {
  default_route_table_id = "${aws_vpc.vpc_main.default_route_table_id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }
}

resource "aws_route_table_association" "public_a_rta" {
  subnet_id      = "${aws_subnet.public_subnet_a.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "public_b_rta" {
  subnet_id      = "${aws_subnet.public_subnet_b.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
