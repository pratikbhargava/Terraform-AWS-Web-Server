# AWS-Web-Server-using-Terraform - EC2 Autoscaling  Module
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| associate\_public\_ip\_address | If true, the EC2 instance will have associated public IP address | `bool` | `false` | no |
| data\_vol\_size | Input the data volume size | `number` | `30` | no |
| disable\_api\_termination | If true, enables EC2 Instance Termination Protection | `bool` | `false` | no |
| get\_password\_data | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| iam\_instance\_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `"ssm-role-profile"` | no |
| image\_id | The AMI ID if Image | `string` | `"ami-0f7cfd001f4fa1b77"` | no |
| instance\_type | The type of instance to start | `string` | `"t2.micro"` | no |
| key\_name | SSH Key name | `string` | `"webserver"` | no |
| name | The name of the server | `string` | `"web-server"` | no |
| region | The name of the region to deploy to | `string` | `"us-east-1"` | no |
| root\_vol\_size | Input the root volume size | `number` | `20` | no |
| security\_groups | Security Groups | `list` | `[]` | no |
| subnet\_ids | Subnet ID | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_autoscaling\_group\_id | The autoscaling group id |
| aws\_autoscaling\_group\_name | The autoscaling group name |
| aws\_launch\_configuration\_id | The ID of the launch configuration |
| aws\_launch\_configuration\_name | The name of the launch configuration |

