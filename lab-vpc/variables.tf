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

variable "private_block_a" {
  default = "10.0.32.0/20"
}

variable "private_block_b" {
  default = "10.0.48.0/20"
}

variable "public_az_a" {
  default = "us-east-1a"
}

variable "public_az_b" {
  default = "us-east-1b"
}

variable "private_az_a" {
  default = "us-east-1a"
}

variable "private_az_b" {
  default = "us-east-1b"
}
