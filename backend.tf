terraform {
  backend "s3" {
    bucket = "terraform-project-group3"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}
