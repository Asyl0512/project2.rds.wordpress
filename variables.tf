variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to use for WordPress."
  type        = string
}

variable "vpc_cidr" {
  type        = string
  description = "Provide vpc cidr block"
}

variable "subnets" {
  description = "A map of subnets keyed by name with CIDR and AZ as values."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "ami" {
  description = "The AMI ID to be used for the EC2 instances."
  type        = string
}

variable "database_details" {
  description = "Configuration details for the RDS instance."
  type = object({
    instance_class    = string
    allocated_storage = number
    engine            = string
    engine_version    = string
    username          = string
    password          = string
    db_name           = string
  })
}
