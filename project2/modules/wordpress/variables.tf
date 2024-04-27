variable "region" {
  type        = string
  description = "Provide region"
}

variable "vpc_cidr" {
  type        = string
  description = "Provide vpc cidr block"
}

variable "subnets" {
  description = "A map of subnet specifications keyed by subnet name, each containing CIDR block and availability zone."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type        = string
  description = "The AMI ID to be used for the EC2 instances."
}

variable "database_details" {
  type = object({
    instance_class    = string # e.g., db.t3.micro
    allocated_storage = number # Storage in GB
    engine            = string # e.g., mysql, postgresql
    engine_version    = string # e.g., 5.7 for MySQL
    username          = string # Username for DB access
    password          = string # Password for DB access
    db_name           = string # Database name
  })
  description = "Configuration details for the RDS instance."
}
