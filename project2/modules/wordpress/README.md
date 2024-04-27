# WordPress module

Creates VPC, subnets, route table with association, Internet Gateway, EC2 and RDS instances along with subnet group.

## Deployment

```
terraform init
terraform plan
terraform apply
```

## Create main.tf file and input following

```hcl
module "wordpress" {
  source = "Asyl0512/project2.rds.wordpress/project2/modules/wordpress"
  region            = "us-east-1"
  version           = "0.0.1"
  vpc_cidr          = "10.0.0.0/16"
  subnet1_cidr = "10.0.1.0/24"
  subnet2_cidr = "10.0.2.0/24" 
  subnet3_cidr = "10.0.3.0/24"
  instance_type = "t2.micro"
  ami = "ami-04e5276ebb8451442"
  database_details  = {
    instance_class    = string
    allocated_storage = number
    engine            = string
    engine_version    = string
    username          = string
    password          = string
    db_name           = string
  }
  ports = [
         {from_port = 22, to_port = 22},
         {from_port = 80, to_port = 80},   
         {from_port = 3306, to_port = 3306},
         {from_port = 443, to_port = 443}
    ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.wordpress_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_instance.group_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route_table.rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.group_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.wordpress_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.wordpress_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI ID to be used for the EC2 instances. | `string` | n/a | yes |
| <a name="input_database_details"></a> [database\_details](#input\_database\_details) | Configuration details for the RDS instance. | <pre>object({<br>    instance_class    = string # e.g., db.t3.micro<br>    allocated_storage = number # Storage in GB<br>    engine            = string # e.g., mysql, postgresql<br>    engine_version    = string # e.g., 5.7 for MySQL<br>    username          = string # Username for DB access<br>    password          = string # Password for DB access<br>    db_name           = string # Database name<br>  })</pre> | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Provide region | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnet specifications keyed by subnet name, each containing CIDR block and availability zone. | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Provide vpc cidr block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_private_ip"></a> [ec2\_private\_ip](#output\_ec2\_private\_ip) | The private IP address of the EC2 instance. |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | The public IP address of the EC2 instance. |
| <a name="output_rds_address"></a> [rds\_address](#output\_rds\_address) | The DNS of the RDS instance. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | The connection endpoint for the RDS instance. |
<!-- END_TF_DOCS -->