variable "region" {
    description = "The AWS region to create resource in."
    default = "us-west-2"
  
}
variable "cluster_name" {
    description = "The name of the EKS cluster"
    default = "eks-cluster"
  
}
variable "node_instance_type" {
    description = "EC2 instance type for the EKS nodes"
    default = "t3.medium"
  
}
variable "desired_capacity" {
    description = "Desired number of worker nodes"
    default = 2
  
}
variable "max_capacity" {
    description = "Maximum number of worker nodes"
    default = 3

}
variable "min_capacity" {
    description = "Minimum number of worker nodes."
    default = 1
  
}
variable "key_name" {
    description = "SSH key pair name for accessing the EKS nodes."
    default = "my-key-pair" #Change this to your key pair name
  
}
