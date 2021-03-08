output "aws_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = aws_launch_configuration.lc.id
}

output "aws_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = aws_launch_configuration.lc.name
}

output "aws_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.asg.id
}

output "aws_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = aws_autoscaling_group.asg.name
}

