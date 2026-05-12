module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = var.tags
}

module "eks_cluster" {
  source                  = "./modules/cluster"
  project_name            = var.project_name
  tags                    = var.tags
  public_subnet_1a        = module.eks_network.pub_subnet_1a
  public_subnet_1b        = module.eks_network.pub_subnet_1b
  cluster_version         = var.cluster_version
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  access_entries          = var.access_entries
}

module "eks_managed_node_group" {
  source             = "./modules/managed-node-group"
  project_name       = var.project_name
  cluster_name       = module.eks_cluster.cluster_name
  private_subnet_1a  = module.eks_network.priv_subnet_1a
  private_subnet_1b  = module.eks_network.priv_subnet_1b
  tags               = var.tags
  auto_scale_options = var.auto_scale_options
  disk_size          = var.disk_size
  ami_type           = var.ami_type
  instance_types     = var.instance_types
  capacity_type      = var.capacity_type
}

module "eks_aws_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  project_name = var.project_name
  tags         = var.tags
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
  vpc_id       = module.eks_network.vpc_id
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group
  ]
}

module "eks_aws_addons" {
  source                  = "./modules/cluster-addons"
  project_name            = var.project_name
  tags                    = var.tags
  cluster_name            = module.eks_cluster.cluster_name
  addon_coredns_version   = var.addon_coredns_version
  addon_kubeproxy_version = var.addon_kubeproxy_version
  addon_cni_version       = var.addon_cni_version
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_load_balancer_controller
  ]
}

module "eks_metrics_server" {
  source       = "./modules/metrics-server"
  project_name = var.project_name
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_load_balancer_controller
  ]
}

module "eks_kube_state_metrics" {
  source       = "./modules/kube-state-metrics"
  project_name = var.project_name
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_load_balancer_controller
  ]
}
