## Requirements

This will create Security Group with rules which will allow communicaion between ALB and Web servers.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| terraform | 0.14.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| code\_version | version of code released | `string` | `"0.0.2"` | no |
| customer\_name | Name of the customer | `string` | `"AllnOne Limited"` | no |
| name | Name of Security Group | `string` | `"secgrp-ew1-p-web-priv"` | no |
| region | The AZ for this environment | `string` | `"eu-west-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| websg | The ID of the security group |

