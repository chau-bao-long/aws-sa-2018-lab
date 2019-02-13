variable "app_name" {
  default = "topcbl aws lab"
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

variable "root_segment" {
  default = "10.0.0.0/16"
}
