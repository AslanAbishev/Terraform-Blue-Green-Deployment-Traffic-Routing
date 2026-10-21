data "aws_vpc" "main" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet" "public1" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.public_subnet1_name
  }
}

data "aws_subnet" "public2" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.public_subnet2_name
  }
}

data "aws_security_group" "ssh" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.ssh_security_group_name
  }
}

data "aws_security_group" "http" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.http_security_group_name
  }
}

data "aws_security_group" "lb" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.lb_security_group_name
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = var.ami_owners
  name_regex  = var.ami_name_regex
}
