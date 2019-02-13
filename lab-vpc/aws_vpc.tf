resource "aws_vpc" "vpc_main" {
  cidr_block = "${var.root_block}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.app_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.public_block_a}"
  availability_zone = "#{var.public_az_a}"
  tags = {
    Name = "${var.app_name}-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.public_block_b}"
  availability_zone = "#{var.public_az_b}"
  tags = {
    Name = "${var.app_name}-public-b"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.private_block_a}"
  availability_zone = "#{var.private_az_a}"
  tags = {
    Name = "${var.app_name}-private-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${var.private_block_b}"
  availability_zone = "#{var.private_az_b}"
  tags = {
    Name = "${var.app_name}-private-b"
  }
}
