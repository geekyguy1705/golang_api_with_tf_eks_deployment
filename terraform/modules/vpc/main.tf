data "aws_availability_zones" "azs" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "vpc-${var.project_name}"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  create_flow_log_cloudwatch_log_group = false

  tags = merge(var.tags, {
    "kubernetes.io/cluster/eks-${var.project_name}" = "shared"
  })

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.project_name}" = "shared"
    "kubernetes.io/role/internal-elb"       = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.project_name}" = "shared"
    "kubernetes.io/role/elb"                = "1"
  }
}