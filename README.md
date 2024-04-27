<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wordpress"></a> [wordpress](#module\_wordpress) | ./modules/wordpress | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI ID to be used for the EC2 instances. | `string` | n/a | yes |
| <a name="input_database_details"></a> [database\_details](#input\_database\_details) | Configuration details for the RDS instance. | <pre>object({<br>    instance_class    = string<br>    allocated_storage = number<br>    engine            = string<br>    engine_version    = string<br>    username          = string<br>    password          = string<br>    db_name           = string<br>  })</pre> | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of EC2 instance to use for WordPress. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy resources into. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnets keyed by name with CIDR and AZ as values. | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Provide vpc cidr block | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->