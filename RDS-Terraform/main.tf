#Define provider and version
terraform {
    required_providers {
      aws={
        source = "hashicorp/aws"
        version = "~>3.0"
      }
    }
}

#configure AWS provider

provider "aws" {
    region = "us-west-2"
  
}

#Define variables
variable "instance_type" {
    description = "The type of EC2 instance to launch"
    default = "t2.micro"
  
}
variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
  
}
variable "subnet_id" {
    description = "The sbunet ID for thr EC2 instance"
  
}
variable "security_group_ids" {
    description = "List of security group IDs for the EC2 instance"
    type = list(string)
  
}

#Create a new VPC with an Internet Gateway and a route Table
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block="0.0.0.0./0"
        gaateway_id=aws_internet_gateway.gw.id
    }
  
}
resource "aws_route_table_association" "public_subnet" {
 subnet_id = var.subnet_id
 route_table_id = aws_route_table.public.id
}

#Create an EC2 instance

resource "aws_instance" "Myinstance" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group_ids

    tags = {
      name = "Einstance"
    }
  
}