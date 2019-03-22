resource "aws_internet_gateway" "vpc_main_igw" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  tags = {
    Name = "lab-architect-gateway"
  }
}

