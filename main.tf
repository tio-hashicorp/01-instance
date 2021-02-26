provider "aws" {
  region = "us-east-2"
}

resource "aws_instance"   "app" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-2a"
  ami               = "ami-0c55b159cbfafe1f0"
 subnet_id          = aws_subnet.mysubnet.id
}

variable "cidrs" {
  default = ["172.31.0.0/16", "172.16.0.0/16"]
}

resource "aws_vpc" "hashicat" {
  count = 2
  cidr_block           = var.cidrs[count.index]
  enable_dns_hostnames = true

  tags = {
    name = "dsta-vpc.${count.index}"
    environment = "Production.${count.index}"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id = aws_vpc.hashicat[1].id
  cidr_block = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "tf-example"
  }
}


