resource "aws_launch_template" "eks_nodes" {
  name_prefix = "eks-storage-nodes-"

  bootstrap_extra_args   = "--use-max-pods=false --kubelet-extra-args=--max-pods=110"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp3"
      iops        = 3000
      throughput  = 150
      encrypted   = true
      delete_on_termination = true
    }
  }
}
