resource "aws_subnet" "public_subnet_a" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.public_block_a}"
  availability_zone = "${var.public_az_a}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.public_block_b}"
  availability_zone = "${var.public_az_b}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-public-b"
  }
}
