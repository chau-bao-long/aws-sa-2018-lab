resource "aws_internet_gateway" "vpc_main_igw" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  tags = {
    Name = "lab-architect-gateway"
  }
}

resource "aws_vpc_endpoint" "s3_ep" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  vpc_endpoint_type = "Gateway"
  service_name = "${var.ep_service_name}"
  route_table_ids = [
    "${aws_route_table.public_rt.id}",
    "${aws_vpc.vpc_main.default_route_table_id}",
  ]
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.public_subnet_a.id}"
}
