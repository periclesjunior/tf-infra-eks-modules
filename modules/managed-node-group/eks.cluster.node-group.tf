resource "aws_eks_node_group" "eks_managed_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-nodegroup"
  node_role_arn   = aws_iam_role.eks_mng_role.arn

  subnet_ids = [
    var.private_subnet_1a,
    var.private_subnet_1b
  ]

  ami_type               = "AL2023_x86_64_STANDARD"
  instance_types         = ["t3.medium"]
  capacity_type          = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  create_launch_template = true
  launch_template_name   = "app"
  bootstrap_extra_args   = "--use-max-pods=false --kubelet-extra-args=--max-pods=110"

  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 20
        volume_type           = "gp3"
        iops                  = 3000
        throughput            = 150
        encrypted             = true
        delete_on_termination = true
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nodegroup"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
  ]
}
