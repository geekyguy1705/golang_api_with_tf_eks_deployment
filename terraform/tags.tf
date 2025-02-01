locals {
  common_tags = {
    created_by  = var.created_by
    created_on  = timestamp()
    cost_center = var.cost_center
    env         = var.env
  }
}