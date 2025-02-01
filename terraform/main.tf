module "vpc" {
  source = "./modules/vpc"
  private_subnets = var.public_subnets
  public_subnets  = var.private_subnets
  project_name = var.project_name
  tags = local.common_tags
  vpc_cidr = var.vpc_cidr
}

module "eks" {
  source = "./modules/eks"
  cluster_version = var.cluster_version
  enable_irsa     = var.enable_irsa
  instance_types  = var.instance_types
  ng_desired_size = var.ng_desired_size
  ng_max_size     = var.ng_max_size
  ng_min_size     = var.ng_min_size
  project_name    = var.project_name
  tags            = local.common_tags
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  eks_sg_id = aws_security_group.eks-sg.id
}

resource "aws_security_group" "eks-sg" {
  name   = "eks-sg-${var.project_name}"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "eks-sg-ingress" {
  description       = "allow inbound traffic from eks"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.eks-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-sg-ingress" {
  description       = "allow inbound traffic from eks"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.eks-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-sg-egress" {
  description       = "allow outbound traffic to eks"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.eks-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}