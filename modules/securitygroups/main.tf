resource "aws_security_group" "web-sg" {
  name        = var.name
  description = "web-private"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.name
  }

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  ingress = [
    {
      cidr_blocks      = var.cidr_blocks
      description      = "SSH"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = var.vpc_cidr
      description      = "SSM"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = []
      description      = "https traffic in"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = var.security_groups
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = []
      description      = "http traffic in"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = var.security_groups
      self             = false
      to_port          = 80
    },
  ]
}
