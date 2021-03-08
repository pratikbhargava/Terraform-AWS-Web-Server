# AWS-Web-Server-using-Terraform
AWS Web Server using Terraform, which includes VPC, EC2, ELB, EC2 Auto Scaling.

## Requirements

AWS session tokens: 
export AWS_ACCESS_KEY_ID=<Access-key-from-output>
export AWS_SECRET_ACCESS_KEY=<Secret-access-key-from-output>
export AWS_SESSION_TOKEN=<Session-Token-from-output>

Without Access Key/ ID/ Session Token, code will not be able to deploy in AWS account.


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_name | Name of the AMI for the jumphost. For Amazon Linux 2 use amzn2-ami-hvm-2.0.????????.?-x86\_64-gp2 and for Ubuntu use ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????. | `string` | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????"` | no |
| ami\_owner | AMI owner name. For Amazon Linux 2 use amazon, and for Ubuntu use 099720109477. | `string` | `"099720109477"` | no |
| create\_attachment | Create the elb attachment or not | `bool` | `true` | no |
| create\_elb | Create the elb or not | `bool` | `true` | no |
| create\_vpc | Create the vpc or not | `bool` | `true` | no |
| data\_vol\_size | Input the data volume size | `number` | `10` | no |
| instance\_type | Instance type for the jumphost. | `string` | `"t2.micro"` | no |
| internal | If true, ELB will be an internal ELB | `bool` | `false` | no |
| key\_name | SSH Key name | `string` | `"pratik-nextGen-AWS"` | no |
| name | Name to be used on all the resources as identifier | `string` | `"production"` | no |
| private\_subnets | List of Private subnets CIDRS will be created | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| public\_subnets | List of Public subnet Cidrs  will be created | `list(string)` | <pre>[<br>  "10.0.0.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| region | AWS Deployment region.. | `string` | `"us-east-1"` | no |
| root\_vol\_size | Input the root volume size | `number` | `15` | no |
| vpc\_cidr | The CIDR block for the VPC. Default value is a valid CIDR. | `string` | `"10.0.0.0/16"` | no |


## Outputs

| Name | Description |
|------|-------------|
| availability\_zone | List of availability zones of instances |
| elb\_arn | The ARN of the ELB |
| elb\_dns\_name | The DNS name of the ELB |
| elb\_id | The name of the ELB |
| elb\_instances | The list of instances in the ELB |
| elb\_name | The name of the ELB |
| elb\_security\_group\_id | The ID of the ELB Server Security Group |
| elb\_source\_security\_group | The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only. |
| id | List of IDs of instances |
| igw\_id | The ID of the Internet Gateway |
| key\_name | List of key names of instances |
| natgw\_ids | List of NAT Gateway IDs |
| private\_subnets | List of IDs of private subnets |
| private\_subnets\_cidr\_blocks | List of cidr\_blocks of private subnets |
| profile\_id | EC2 instance profile id |
| public\_subnets | List of IDs of public subnets |
| public\_subnets\_cidr\_blocks | List of cidr\_blocks of public subnets |
| subnet\_id | List of IDs of VPC subnets of instances |
| voulme\_ids | List of Volume IDs attached to the instances |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |
| vpc\_security\_group\_ids | List of associated security groups of instances, if running in non-default VPC |
| webserver\_security\_group\_id | The ID of the Web Server Security Group |

