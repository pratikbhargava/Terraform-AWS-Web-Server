variable "region" {
  description = "AWS Deployment region.."
  default     = "us-east-1"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of Private subnets CIDRS will be created"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}


variable "public_subnets" {
  type        = list(string)
  description = "List of Public subnet Cidrs  will be created"
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
}


variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "production"
}

variable "create_vpc" {
  description = "Create the vpc or not"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami_name" {
  description = "Name of the AMI for the jumphost. For Amazon Linux 2 use amzn2-ami-hvm-2.0.????????.?-x86_64-gp2 and for Ubuntu use ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????."
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????"
}

variable "ami_owner" {
  description = "AMI owner name. For Amazon Linux 2 use amazon, and for Ubuntu use 099720109477."
  type        = string
  default     = "099720109477"
}

variable "instance_type" {
  description = "Instance type for the jumphost."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "SSH Key name"
  #default     = "webserver"
  default = "pratik-nextGen-AWS"
}

variable "root_vol_size" {
  description = "Input the root volume size"
  type        = number
  default     = 15
}

variable "data_vol_size" {
  description = "Input the data volume size"
  type        = number
  default     = 10
}

variable "create_elb" {
  description = "Create the elb or not"
  type        = bool
  default     = true
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
  default     = false
}

variable "create_attachment" {
  description = "Create the elb attachment or not"
  type        = bool
  default     = true
}
