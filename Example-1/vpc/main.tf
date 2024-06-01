provider "aws" {
    region = var.region
}
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = var.instance_tenancy
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = var.vpc_name
      environment =var.environment
    }
 
}