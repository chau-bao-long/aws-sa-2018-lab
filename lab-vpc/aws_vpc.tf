resource "aws_vpc" "vpc_main" {
  cidr_block = "${var.root_block}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.app_name}-vpc"
  }
}
