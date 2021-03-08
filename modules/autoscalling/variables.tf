variable "name" {
  description = "The name of the server"
  type        = string
  default     = "web-server"
}

variable "region" {
  description = "The name of the region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "SSH Key name"
  default     = "webserver"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "image_id" {
  description = "The AMI ID if Image"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = "ssm-role-profile"
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
  type        = list
  default     = []
}

variable "elb_id" {
  description = "The name of the ELB"
  type        = string
  default     = ""
}
