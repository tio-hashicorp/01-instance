
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance"   "demo-vm" {
  instance_type         = var.vm_type
  availability_zone     = "us-east-2a"
  ami                   = "ami-0c55b159cbfafe1f0"
  subnet_id             = aws_subnet.demo-subnet.id
  
  tags = {
    Name        = var.vm_name
    Billable    = "true"
    Department  = var.dept_name
  }
}

resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.cidrs
  enable_dns_hostnames = true

  tags = {
    Name        = "demo-vpc"
    Billable    = "true"
    Department  = var.dept_name
  }
}

resource "aws_subnet" "demo-subnet" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "tf-example"
  }
}


#####################
# output
#####################
output "demo-vm-ip" {
    value = aws_instance.demo-vm.private_ip
}

output "demo-vm-public-ip" {
    value = aws_instance.demo-vm.public_ip  
}  
######################
# all the variables
######################

variable "cidrs" {
    default = "172.16.0.0/16"
}

variable "vm_type" {
    default = "t2.micro"
}

variable "vm_name" {
    default = "default-vm"
}

variable "dept_name" {
    default = "Sales"
}
