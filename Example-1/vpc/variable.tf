variable "region" {
    description = "AWS region"
    default = "us-east-1"
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}
variable "instance_tenancy" {
    description = "Tenancy options for instances launched into th VPC"
    default = "default"
  
}
variable "vpc_name" {
    description = "Name of the VPC"
  
}
variable "environment" {
    description = "Dev"
  
}