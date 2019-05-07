variable "app_name" {
  default = "lab-architect"
}

variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
  default     = "us-east-1"
}

variable "root_block" {
  default = "10.0.0.0/16"
}

variable "public_block_a" {
  default = "10.0.0.0/20"
}

variable "public_block_b" {
  default = "10.0.16.0/20"
}

variable "public_az_a" {
  default = "us-east-1a"
}

variable "public_az_b" {
  default = "us-east-1b"
}

variable "key_name" {
  default = "lab_elb_key"
}

variable "amis" {
  type = "map"

  default = {
    linux_hvm_ssd = "ami-0ff8a91507f77f867"
    amazon_linux_ami_201803_ssd = "ami-0080e4c5bc078760e"
  }
}
