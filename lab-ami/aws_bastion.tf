resource "aws_instance" "web_instance" {
  ami = "${var.amis["amazon_linux_ami_201803_ssd"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet.id}"
  key_name = "${var.key_name}"
  associate_public_ip_address = "true"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination = "false"
  monitoring = "false"
  user_data = <<EOF
    #!/bin/sh
    yum update
  EOF
  root_block_device {
    volume_type = "standard"
    volume_size = "10"
    iops = "100"
    delete_on_termination = "true"
  }
  vpc_security_group_ids = [
    "${aws_security_group.sg_web.id}"
  ]
  tags = {
    Name = "lab-architect-bastion"
  }
}

resource "aws_key_pair" "key_pair" {
  key_name = "${var.key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj5qUnA7n1jKOIF59Mp0MHi+Mty0AJtsZdERO3MlFv5YqNmfo4568rcejEKqyYAQ1+0RfWYm8LyrerSmHQCQeSFEgREsBitxOaFZ4zfFhEywj//MX03ZFbJc46ojblEeAOZ1TM6ywOd8C6bnUj8MILRlW0p8xZquTlyJMgO2PxHk7l84lLxc+K4mj5ddvwQmZUSjh1El8uMPq00eKt5LZpZ1eg5nmOkZxreql7HpBKJgx/iNzIP21/DQQJ1jn8O0ZXgt2V6/kPboDa6yBPMUY2wsAounpIjA8LDB1I6uF5e66V9EemKfnK9antm9hN4SgCQ2sxLDeUyPddcU/R64AF chau.bao.long@b120594-mb.local"
}
