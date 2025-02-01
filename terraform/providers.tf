terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }

  backend "local" {
    path="tfstate/terraform.tfstate"
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
}