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

resource "aws_route_table_association" "public_rta" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
