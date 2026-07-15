resource "aws_launch_template" "eks_nodes" {
  for_each = local.launch_template_node_groups

  name = coalesce(
    each.value.launch_template_name,
    "${var.project_name}-${each.key}"
  )

  description = "EKS managed node group launch template for ${each.key}"
  user_data   = base64encode(local.nodeadm_user_data[each.key])

  dynamic "block_device_mappings" {
    for_each = each.value.block_device_mappings

    content {
      device_name = block_device_mappings.value.device_name

      ebs {
        volume_size           = block_device_mappings.value.ebs.volume_size
        volume_type           = block_device_mappings.value.ebs.volume_type
        iops                  = block_device_mappings.value.ebs.iops
        throughput            = block_device_mappings.value.ebs.throughput
        encrypted             = block_device_mappings.value.ebs.encrypted
        delete_on_termination = block_device_mappings.value.ebs.delete_on_termination
        kms_key_id            = block_device_mappings.value.ebs.kms_key_id
      }
    }
  }

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name      = coalesce(each.value.launch_template_name, "${var.project_name}-${each.key}")
      NodeGroup = each.key
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
