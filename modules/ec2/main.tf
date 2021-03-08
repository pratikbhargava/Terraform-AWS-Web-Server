## Data lookup for AMI
data "aws_ami" "server_ami" {

  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  owners = [var.ami_owner]
}
## IAM Profile
resource "aws_iam_instance_profile" "ssm-role-profile" {
  name = "ssm-role-profile"
  role = aws_iam_role.ssm-role.name
}

resource "aws_iam_role" "ssm-role" {
  name               = "ssm-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF
  tags = {
    Name = "ssm-role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm-policy" {
  role       = aws_iam_role.ssm-role.id
  policy_arn = aws_iam_policy.ssm-policy.arn
}

resource "aws_iam_policy" "ssm-policy" {
  name        = "${terraform.workspace}-ssm_policy"
  path        = "/"
  description = "SSM policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ds:CreateComputer",
                "ds:DescribeDirectories",
                "ec2:DescribeInstanceStatus",
                "logs:*",
                "ssm:*",
                "ec2messages:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "ssm.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:DeleteServiceLinkedRole",
                "iam:GetServiceLinkedRoleDeletionStatus"
            ],
            "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

## Web servers

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.instance_type
  user_data              = file("${path.module}/install_apache.sh")
  subnet_id              = var.subnet_ids
  key_name               = var.key_name
  vpc_security_group_ids = var.security_groups
  source_dest_check      = true
  iam_instance_profile   = aws_iam_instance_profile.ssm-role-profile.id

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_vol_size
    delete_on_termination = true
  }
  volume_tags = {
    Name = var.name
  }
  tags = {
    Name = var.name
  }
}

resource "aws_ebs_volume" "data_vol" {
  availability_zone = aws_instance.web_server.availability_zone
  size              = var.data_vol_size
  type              = "gp2"
  encrypted         = true
  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data_vol.id
  instance_id = aws_instance.web_server.id
}

