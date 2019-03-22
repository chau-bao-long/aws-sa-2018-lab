resource "aws_iam_role" "s3_role" {
  name = "s3_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name = "lab-s3-role"
  }
}

resource "aws_iam_instance_profile" "s3_profile" {
  name = "s3_profile"
  role = "${aws_iam_role.s3_role.name}"
}

# There are 2 ways to attach S3 policy to iam role: (pick one)

# 1. attach aws managed policy (default policy)
# data "aws_iam_policy" "s3_role_policy" {
#   arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "s3_role_attachment" {
#   role       = "${aws_iam_role.s3_role.name}"
#   policy_arn = "${data.aws_iam_policy.s3_role_policy.arn}"
# }

# 2. attach inline policy 
resource "aws_iam_role_policy" "s3_role_policy" {
  name = "s3_role_policy"
  role = "${aws_iam_role.s3_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
