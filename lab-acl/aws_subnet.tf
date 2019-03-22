resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.public_block}"
  availability_zone = "${var.public_az}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-public-subnet"
  }
}
