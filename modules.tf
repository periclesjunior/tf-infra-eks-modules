module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = var.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  cluster_version  = var.cluster_version
  tags             = var.tags
  public_subnet_1a = module.eks_network.pub_subnet_1a
  public_subnet_1b = module.eks_network.pub_subnet_1b
}
