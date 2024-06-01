variable "region" {
    description = "AWS region"
  
}
variable "vpc_id" {
    description = "ID of the VPC"
  
}
variable "subnet_ids" {
    description = "List of subnet IDs"
    type = list(string)
  
}
variable "ami_id" {
    description = "AMI ID for instances"
  
}
variable "instance_type" {
    description = "Instance type"
  
}
variable "max_size" {
    description = "Maximum size of Auto Scaling Group"
  
}
variable "min_size" {
    description = "Minimum size of Auto Scaling Group"
  
}
variable "desired_capacity" {
    description = "Desired capacity of Auto Scaling Group"
  
}
variable "user_data" {
    description = "User data for instances"
  
}
variable "db_engine" {
    description = "Database engine"
  
}
variable "db_engine_version" {          
    description = "Database engine version" 
}
variable "db_instance_class" {
    description = "Database instance class"
  
}
variable "db_allocated_storage" {
  description = "Allocated storage for database"
}
variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
}
variable "db_username" {
    description = "Username for the database access"  
}
variable "db_password" {
  description = "Password for database access"
}