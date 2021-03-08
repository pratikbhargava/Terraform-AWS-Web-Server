variable "region" {
  default     = "us-east-1"
  description = "The region to deploy to."
  type        = string
}

variable "create_elb" {
  description = "Create the elb or not"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the ELB"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = list(string)
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "listener" {
  description = "A list of listener blocks"
  type        = list(map(string))
  default     = []
}

variable "health_check" {
  description = "A health check block"
  type        = map(string)
  default     = {}
}

variable "create_attachment" {
  description = "Create the elb attachment or not"
  type        = bool
  default     = true
}

variable "number_of_instances" {
  description = "Number of instances ID to place in the ELB pool"
  type        = number
}

variable "elb" {
  description = "The name of the ELB"
  type        = string
  default     = ""
}

variable "instances" {
  description = "List of instances ID to place in the ELB pool"
  type        = list(string)
  default     = []
}
