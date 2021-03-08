## AWS Terraform Security Group Module

This module can be used to create new or modify existing security groups. It will handle all options available to the Terraform Security Group Provider.


### Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Security Group | `string` | n/a | yes |
| vpc\_id | VPC ID in which to create the Security Group | `string` | n/a | yes |
| description | Description of the Security Group | `string` | n/a | yes |
| egress\_rules | A schema list of egress rules for the Security Group | `list` | `[]` | no |
| ingress\_rules | A schema list of ingress rules for the Security Group | `list` | `[]` | no |
| revoke\_rules\_on\_delete | Determines whether to forcibly remove rules when destroying the security group | `string` | `false` | no |
| tags | A map of tags for the Security Group | `map(string)` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the Security Group |
| id | The ID of the Security Group |
| name | The name of the Security Group |
| owner\_id | The owner ID of the Security Group |


### Examples
* Ingress Rule

        ingress_rules = [
          {
            "from_port"   = "80",
            "to_port"     = "80",
            "protocol"    = "tcp",
            "cidr_blocks" = ["0.0.0.0/0"]
          }
        ]

* Egress Rule

        egress_rules = [
          {
            "from_port"   = "80",
            "to_port"     = "80",
            "protocol"    = "tcp",
            "cidr_blocks" = ["0.0.0.0/0"]
          }
        ]

* Full Example

        module "example_sg" {
          source = "../../modules/security_groups"
          providers = {
            aws = aws
          }
        
          name          = "example-sg"
          description   = "Example EC2 Security Group"
          vpc_id        = "vpc-xxxxxxxxxxxx"
          ingress_rules = [
            {
              "from_port"   = "22",
              "to_port"     = "22",
              "protocol"    = "tcp",
              "cidr_blocks" = ["1.2.3.4/32", "4.5.6.7/32"]
            }
          ]
          egress_rules = [
            {
              "from_port"   = "80",
              "to_port"     = "80",
              "protocol"    = "tcp",
              "cidr_blocks" = ["0.0.0.0/0"]
            }
            {
              "from_port"   = "443",
              "to_port"     = "443",
              "protocol"    = "tcp",
              "cidr_blocks" = ["0.0.0.0/0"]
            },
          ]
        
          revoke_rules_on_delete = true
        
          tags = {
            managedby = "terraform"
            Name = terraform.workspace
          }
        }


