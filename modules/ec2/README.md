# AWS-Web-Server-using-Terraform - EC2 Module
This Modules creates EC2 instance with one data volume. IAM instance profile for accessing System Manager.
It installs Apache web server on launching using user data.

## Requirements

VPC, Security Groups and SSH key exists

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_name | Name of the AMI for the jumphost. For Amazon Linux 2 use amzn2-ami-hvm-2.0.????????.?-x86\_64-gp2 and for Ubuntu use ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????. | `string` | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????"` | no |
| ami\_owner | AMI owner name. For Amazon Linux 2 use amazon, and for Ubuntu use 099720109477. | `string` | `"099720109477"` | no |
| data\_vol\_size | Input the data volume size | `number` | `30` | no |
| disable\_api\_termination | Enable termination protection for the jumphost. | `bool` | `false` | no |
| instance\_type | Instance type for the jumphost. | `string` | `"t2.micro"` | no |
| key\_name | SSH Key name | `string` | `"webserver"` | no |
| name | The name of the server | `string` | `"web-server"` | no |
| region | The region to deploy to. | `string` | `"us-east-1"` | no |
| root\_vol\_size | Input the root volume size | `number` | `20` | no |
| security\_groups | Security Groups | `list` | `[]` | no |
| subnet\_ids | Subnet ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | List of ARNs of instances |
| availability\_zone | List of availability zones of instances |
| id | List of IDs of instances |
| key\_name | List of key names of instances |
| subnet\_id | List of IDs of VPC subnets of instances |
| voulme\_ids | List of Volume IDs attached to the instances |
| vpc\_security\_group\_ids | List of associated security groups of instances, if running in non-default VPC |

