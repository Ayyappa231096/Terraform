provider "aws" {
    region = "var.region"
  
}

#Create vpc
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.19.0"

    name = "eks-vpc"
    cidr = "10.0.0.0/16"

    azs = ["${var.region}a","${var.region}b","${var.region}c"]
    private_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]

   # enable_nat_gateway = true
   # single_nat_gateway = true

    tags = {
        Name="eks-vpc"
    }
}

#EKS Cluster

module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "18.30.0"
    cluster_name = "var.cluster_name"
    cluster_version = "1.28"
    subnet_ids = module.vpc.private_subnets
    vpc_id = module.vpc.vpc_id

    #Managed Node Groups
    eks_managed_node_groups = {
        eks_nodes ={
            desired_capacity = var.desired_capacity
            max_capacity = var.max_capacity
            min_capacity = var.min_capacity

            instance_type = var.node_instance_type
            key_name =var.key_name
        }
    }
    tags = {
        environment ="dev"
        Name = var.cluster_name
    }
}

output "cluster_name" {
    value = module.eks.cluster_id
  
}

output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
  
}

output "cluster_security_group_id" { 
    value = module.eks.cluster_security_group_id
  
}

output "kubectl_config" {
    value = module.eks.kubectl_config
    sensitive = true
  
}
  
