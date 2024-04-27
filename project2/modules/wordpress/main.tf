# VPC
resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "group-3"
  }
}

# Subnets
resource "aws_subnet" "wordpress_subnet" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "${each.key}-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.wordpress_vpc.id
}

# Route Table and Associations
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.wordpress_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  for_each       = aws_subnet.wordpress_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

# EC2 Instance
resource "aws_instance" "group_3" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = tolist(values(aws_subnet.wordpress_subnet))[0].id
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.group_3.id]
  tags = {
    Name = "Group-3-ec2"
  }
  user_data = <<-EOF
                            #!/bin/bash
                            yum update -y
                            yum install -y httpd php php-mysqlnd
                            systemctl start httpd
                            systemctl enable httpd
                            cd /var/www/html
                            wget https://wordpress.org/latest.tar.gz
                            tar -xzf latest.tar.gz
                            cp -r wordpress/* .
                            rm -rf wordpress latest.tar.gz
                            EOF
}


# RDS Instance
resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = var.database_details.allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.database_details.instance_class
  identifier             = "wordpressdb"
  username               = var.database_details.username
  password               = var.database_details.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.group_3.id]
  skip_final_snapshot    = true
}


# Database Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name       = "my-db-subnet-group"
  subnet_ids = values(aws_subnet.wordpress_subnet).*.id
}

# Subdomain

resource "aws_route53_record" "subdomain" {
  zone_id = "Z06738651TK0FJ6ZYYGU5" // Replace with your hosted zone ID
  name    = "a-syl.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.group_3.public_ip] // Replace with the IP address of your web server
}
