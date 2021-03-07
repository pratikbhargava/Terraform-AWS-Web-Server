variable "name" {
  description = "Name of Security Group"
  type        = string
  default     = "secgrp-ew1-p-web-priv"
}

variable "region" {
  description = "The AZ for this environment"
  type        = string
  default     = "eu-west-1"
}

variable "code_version" {
  description = "version of code released"
  type        = string
  default     = "0.0.2"
}

variable "customer_name" {
  type        = string
  default     = "AllnOne Limited"
  description = "Name of the customer"
}
