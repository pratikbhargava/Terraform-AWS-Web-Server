# AWS-Web-Server-using-Terraform - ELB Module
This module which creates ELB and ELB Attachment resources on AWS.
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_attachment | Create the elb attachment or not | `bool` | `true` | no |
| create\_elb | Create the elb or not | `bool` | `true` | no |
| cross\_zone\_load\_balancing | Enable cross-zone load balancing | `bool` | `true` | no |
| elb | The name of the ELB | `string` | `"xxdd"` | no |
| health\_check | A health check block | `map(string)` | `{}` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle | `number` | `60` | no |
| instances | List of instances ID to place in the ELB pool | `list(string)` | `[]` | no |
| internal | If true, ELB will be an internal ELB | `bool` | n/a | yes |
| listener | A list of listener blocks | `list(map(string))` | `[]` | no |
| name | The name of the ELB | `string` | `null` | no |
| number\_of\_instances | Number of instances ID to place in the ELB pool | `number` | n/a | yes |
| region | The region to deploy to. | `string` | `"us-east-1"` | no |
| security\_groups | A list of security group IDs to assign to the ELB | `list(string)` | `[]` | no |
| subnets | A list of subnet IDs to attach to the ELB | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_arn | The ARN of the ELB |
| elb\_dns\_name | The DNS name of the ELB |
| elb\_id | The name of the ELB |
| elb\_instances | The list of instances in the ELB |
| elb\_name | The name of the ELB |
| elb\_source\_security\_group | The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only. |

