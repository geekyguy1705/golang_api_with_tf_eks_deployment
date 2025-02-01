# Common variables
variable "created_by" {
  description = "Team member / Admin who created the resource"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "p41-app"
}

variable "region" {
  description = "Setup region"
  type        = string
  default     = "ap-south-1"
}

variable "cost_center" {
  description = "Billing cost center"
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment Name"
  type        = string
  default     = ""
}

# EKS variavbles
variable "instance_types" {
  description = "VPC name"
  type        = list(string)
  default     = ["t3.nano"]
}

variable "enable_irsa" {
  description = "Enable IAM roles for service accounts"
  type        = bool
  default     = true
}

variable "cluster_version" {
  description = "Kubernetes cluster version"
  type        = string
  default     = "1.32"
}

variable "ng_min_size" {
  description = "Minimum node count for EKS Cluster"
  type        = number
  default     = 1
}

variable "ng_max_size" {
  description = "Maximum node count for EKS Cluster"
  type        = number
  default     = 2
}

variable "ng_desired_size" {
  description = "Desired node count for EKS Cluster"
  type        = number
  default     = 1
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Variables
variable "private_subnets" {
  description = "Private Subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public Subnet CIDR"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Security Group Variables
variable "ingress_cidr_blocks" {
  description = "Ingress Public IP CIDR"
  type        = list(string)
  default     = ["49.43.153.70/32"]
}


