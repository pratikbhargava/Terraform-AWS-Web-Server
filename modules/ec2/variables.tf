variable "name" {
  description = "The name of the server"
  type        = string
  default     = "web-server"
}

variable "region" {
  default     = "us-east-1"
  description = "The region to deploy to."
  type        = string
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
  default     = "webserver"
}

variable "root_vol_size" {
  description = "Input the root volume size"
  type        = number
  default     = 20
}

variable "data_vol_size" {
  description = "Input the data volume size"
  type        = number
  default     = 30
}

variable "security_groups" {
  description = "Security Groups"
  type        = list
  default     = []
}

variable "subnet_ids" {
  description = "Subnet ID"
  type        = string
  default     = ""
}

