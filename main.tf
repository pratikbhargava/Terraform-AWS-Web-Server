
###############
#VPC
##############
module "vpc" {
  source = "./modules/vpc"

  create_vpc = true
  name       = var.name

  cidr = var.vpc_cidr

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  create_igw         = true
  enable_nat_gateway = true
  #  single_nat_gateway = true

}

#################
# Security Groups
#################
# ELB SG
################
module "elb-sg" {
  source = "./modules/securitygroups"

  name        = format("%s-elb-sg", var.name)
  description = "Public ELB Security Group"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    {
      "from_port"   = "80",
      "to_port"     = "80",
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = "443",
      "to_port"     = "443",
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      "from_port"   = "0",
      "to_port"     = "0",
      "protocol"    = "-1",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]

  revoke_rules_on_delete = true

  tags = {
    Name = "${var.name}-elb-sg"
  }
}
###############
# Web server SG
################
module "web-server-sg" {
  source = "./modules/securitygroups"

  name        = format("%s-webserver-sg", var.name)
  description = "EC2 Web server Security Group"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    {
      "from_port"   = "22",
      "to_port"     = "22",
      "protocol"    = "tcp",
      "cidr_blocks" = ["1.2.3.4/32", "4.5.6.7/32"] // Restrict to perticular IPs like office IP
    },
    {
      "from_port"   = "80",
      "to_port"     = "80",
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
      //"security_groups" = [module.elb-sg.id]
    }
  ]
  egress_rules = [
    {
      "from_port"   = "443",
      "to_port"     = "443",
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]

  revoke_rules_on_delete = true

  tags = {
    Name = "${var.name}-sg"
  }
}

##################################
# EC2 Web Server
##################################

module "webserver" {
  source = "./modules/ec2"

  name            = var.name
  ami_name        = var.ami_name
  ami_owner       = var.ami_owner
  instance_type   = var.instance_type
  subnet_ids      = element(module.vpc.private_subnets, 0)
  key_name        = var.key_name
  security_groups = [module.web-server-sg.id]

}

##################################
#  Web Server ELB
##################################

module "webserver-elb" {
  source = "./modules/elb"

  create_elb = var.create_elb

  name            = format("%s-elb", var.name)
  subnets         = module.vpc.public_subnets
  internal        = var.internal
  security_groups = [module.elb-sg.id]

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
    {
      instance_port     = "443"
      instance_protocol = "http"
      lb_port           = "443"
      lb_protocol       = "http"
      //      ssl_certificate_id = module.acm.this_acm_certificate_arn
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  create_attachment   = var.create_elb
  number_of_instances = 1
  instances           = [module.webserver.id]
}

##################################
#  Web Server Autoscaling
##################################
## Data lookup for AMI
data "aws_ami" "server_ami" {

  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  owners = [var.ami_owner]
}

module "webserver-asg" {
  source = "./modules/autoscalling"

  #  create_elb = var.create_elb

  name                 = format("%s-webserver-asg", var.name)
  image_id             = data.aws_ami.server_ami.id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = module.webserver.profile_id
  security_groups      = [module.web-server-sg.id]
  subnet_ids           = [element(module.vpc.private_subnets, 0)]
  root_vol_size        = var.root_vol_size
  data_vol_size        = var.data_vol_size
  elb_id               = module.webserver-elb.elb_id
}
