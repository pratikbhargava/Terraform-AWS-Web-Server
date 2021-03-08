output "elb_id" {
  description = "The name of the ELB"
  value       = concat(aws_elb.web_server_elb.*.id, [""])[0]
}

output "elb_arn" {
  description = "The ARN of the ELB"
  value       = concat(aws_elb.web_server_elb.*.arn, [""])[0]
}

output "elb_name" {
  description = "The name of the ELB"
  value       = concat(aws_elb.web_server_elb.*.name, [""])[0]
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = concat(aws_elb.web_server_elb.*.dns_name, [""])[0]
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = flatten(aws_elb.web_server_elb.*.instances)
}

output "elb_source_security_group" {
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
  value       = concat(aws_elb.web_server_elb.*.source_security_group, [""])[0]
}

