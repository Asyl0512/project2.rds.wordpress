resource "aws_key_pair" "deployer" {
  key_name   = "deployer_key_name"
  public_key = file("~/.ssh/id_rsa.pub")
}