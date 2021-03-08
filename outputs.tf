output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "webserver_security_group_id" {
  description = "The ID of the Web Server Security Group"
  value       = module.web-server-sg.id
}


output "elb_security_group_id" {
  description = "The ID of the ELB Server Security Group"
  value       = module.elb-sg.id
}

output "id" {
  description = "List of IDs of instances"
  value       = module.webserver.id
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = module.webserver.availability_zone
}

output "key_name" {
  description = "List of key names of instances"
  value       = module.webserver.key_name
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = module.webserver.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = module.webserver.subnet_id
}

output "voulme_ids" {
  description = "List of Volume IDs attached to the instances"
  value       = module.webserver.voulme_ids
}

output "elb_id" {
  description = "The name of the ELB"
  value       = module.webserver-elb.elb_id
}

output "elb_arn" {
  description = "The ARN of the ELB"
  value       = module.webserver-elb.elb_arn
}

output "elb_name" {
  description = "The name of the ELB"
  value       = module.webserver-elb.elb_name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = module.webserver-elb.elb_dns_name
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = module.webserver-elb.elb_instances
}

output "elb_source_security_group" {
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
  value       = module.webserver-elb.elb_source_security_group
}
