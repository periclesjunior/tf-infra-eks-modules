module "eks_network" {
  source               = "./modules/network"
  cidr_block           = var.cidr_block
  project_name         = var.project_name
  tags                 = var.tags
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
}

# Public subnet_ids for home labs
module "eks_cluster" {
  source                  = "./modules/cluster"
  project_name            = var.project_name
  tags                    = var.tags
  subnet_ids              = module.eks_network.public_subnet
  cluster_version         = var.cluster_version
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  access_entries          = var.access_entries
  service_ipv4_cidr       = var.service_ipv4_cidr
}

module "eks_managed_node_group" {
  source             = "./modules/managed-node-group"
  project_name       = var.project_name
  cluster_name       = module.eks_cluster.cluster_name
  subnet_ids         = module.eks_network.private_subnet
  tags               = var.tags
  auto_scale_options = var.auto_scale_options
  disk_size          = var.disk_size
  ami_type           = var.ami_type
  instance_types     = var.instance_types
  capacity_type      = var.capacity_type
}

module "eks_aws_lb_controller" {
  source       = "./modules/aws-lb-controller"
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
  source                  = "./modules/eks-aws-addons"
  project_name            = var.project_name
  tags                    = var.tags
  cluster_name            = module.eks_cluster.cluster_name
  oidc                    = module.eks_cluster.oidc
  addon_coredns_version   = var.addon_coredns_version
  addon_kubeproxy_version = var.addon_kubeproxy_version
  addon_cni_version       = var.addon_cni_version
  addon_ebs_csi_version   = var.addon_ebs_csi_version

  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_lb_controller
  ]
}

module "eks_metrics_server" {
  source       = "./modules/metrics-server"
  project_name = var.project_name
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_lb_controller
  ]
}

module "eks_kube_state_metrics" {
  source       = "./modules/kube-state-metrics"
  project_name = var.project_name
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_lb_controller
  ]
}

module "eks_velero" {
  source       = "./modules/velero"
  project_name = var.project_name
  cluster_name = module.eks_cluster.cluster_name
  oidc         = module.eks_cluster.oidc
  region       = var.region
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_lb_controller
  ]
}

module "eks_cluster_autoscaler" {
  source       = "./modules/cluster-autoscaler"
  project_name = var.project_name
  cluster_name = module.eks_cluster.cluster_name
  oidc         = module.eks_cluster.oidc
  region       = var.region
  tags         = var.tags
  depends_on = [
    module.eks_cluster,
    module.eks_managed_node_group,
    module.eks_aws_lb_controller,
    module.eks_metrics_server
  ]
}
