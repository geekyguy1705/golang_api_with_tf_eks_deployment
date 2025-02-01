# Common variables
region = "ap-south-1"
created_by  = "Abhishek Laha"
created_on  = timestamp()
cost_center = "p41"
env         = "dev"

# EKS variables
instance_types         = ["t3.nano"]
enable_irsa = true
cluster_version = "1.32"
ng_min_size     = 1
ng_max_size     = 2
ng_desired_size = 1

# VPC Variables
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

# Security Group Variables
ingress_cidr_blocks      =   ["49.43.153.70/32"]