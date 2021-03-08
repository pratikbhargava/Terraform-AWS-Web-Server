variable "region" {
  default     = "us-east-1"
  description = "The region to deploy to."
  type        = string
}

variable "name" {
  description = "Name of the Security Group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID in which to create the Security Group"
  type        = string
}

variable "description" {
  description = "Description of the Security Group"
  type        = string
}

variable "ingress_rules" {
  description = "A schema list of ingress rules for the Security Group "
  type        = list
  default     = []
}

variable "egress_rules" {
  description = "A schema list of egress rules for the Security Group"
  type        = list
  default     = []
}

variable "revoke_rules_on_delete" {
  description = "Determines whether to forcibly remove rules when destroying the security group"
  type        = string
  default     = false
}

variable "tags" {
  description = "A map of tags for the Security Group"
  type        = map(string)
}
