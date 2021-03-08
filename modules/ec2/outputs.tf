output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.web_server.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = aws_instance.web_server.arn
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = aws_instance.web_server.availability_zone
}

output "key_name" {
  description = "List of key names of instances"
  value       = aws_instance.web_server.key_name
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = aws_instance.web_server.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = aws_instance.web_server.subnet_id
}

output "voulme_ids" {
  description = "List of Volume IDs attached to the instances"
  value       = formatlist("Data Vol - %s,Root Vol - %s", (aws_ebs_volume.data_vol.id), (aws_instance.web_server.root_block_device.0.volume_id))
}

output "profile_id" {
  description = "EC2 instance profile id"
  value       = aws_iam_instance_profile.ssm-role-profile.id
}

