module "eks" {
  depends_on = []
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "eks-${var.project_name}"
  # cluster_name    = "eks-${var.project_name}"
  cluster_version = var.cluster_version
  create_cloudwatch_log_group = false
  kms_key_administrators = ["arn:aws:iam::796973490807:root"]
  # create_kms_key = true
  # attach_cluster_encryption_policy = false

  cluster_endpoint_public_access = true
  enable_irsa = var.enable_irsa

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # cluster_addons = {
  #   coredns                = {}
  #   kube-proxy             = {}
  # }

  tags = var.tags

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = var.instance_types
    vpc_security_group_ids = [var.eks_sg_id]
  }

  eks_managed_node_groups = {
    "ng-${var.project_name}" = {
      min_size     = var.ng_min_size
      max_size     = var.ng_max_size
      desired_size = var.ng_desired_size
    }
  }
}

data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name
}

# Kubernetes config part
provider "helm" {
  kubernetes {
    host = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.main.token
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  }
}
# data "helm_repository" "ingress-nginx" {
#   name             = "ingress-nginx"
#   url  = "https://kubernetes.github.io/ingress-nginx"
# }


resource "helm_release" "ingress-nginx" {
  # repository       = data.helm_repository.ingress-nginx.name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  force_update  = true
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  dependency_update = true
}


provider "kubernetes" {
  host = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  config_paths = [
    "./deployment-configs/dep-simple-time-service-app.yaml",
    "./deployment-configs/svc-simple-time-service-app.yaml",
    "./deployment-configs/ingress.yaml",
  ]
}




# resource "kubernetes_manifest" "this" {
#   manifest = {}
# }
#
# resource "kubernetes_manifest" "deployment" {
#   provider = kubernetes
#   manifest = yamldecode(file("./deployment-configs/dep-simple-time-service-app.yaml"))
# }

