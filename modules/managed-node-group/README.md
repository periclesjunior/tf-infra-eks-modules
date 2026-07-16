<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_eks_node_group.eks_managed_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.eks_mng_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_mng_role_attachment_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_mng_role_attachment_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.eks_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of managed node group definitions. | <pre>map(object({<br/>    min_size               = number<br/>    max_size               = number<br/>    desired_size           = number<br/>    create_launch_template = optional(bool, true)<br/>    launch_template_name   = optional(string)<br/>    ami_type               = optional(string, "AL2023_x86_64_STANDARD")<br/>    instance_types         = list(string)<br/>    capacity_type          = optional(string, "ON_DEMAND")<br/>    max_pods               = optional(number, 110)<br/><br/>    block_device_mappings = optional(map(object({<br/>      device_name = string<br/>      ebs = object({<br/>        volume_size           = number<br/>        volume_type           = optional(string, "gp3")<br/>        iops                  = optional(number, 3000)<br/>        throughput            = optional(number, 150)<br/>        encrypted             = optional(bool, true)<br/>        delete_on_termination = optional(bool, true)<br/>        kms_key_id            = optional(string)<br/>      })<br/>    })), {})<br/><br/>    labels = optional(map(string), {})<br/><br/>    taints = optional(list(object({<br/>      effect = string<br/>      key    = string<br/>      value  = optional(string)<br/>    })), [])<br/><br/>    tags = optional(map(string), {})<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name used in resource names and tags. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Private subnet IDs used by all managed node groups. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags added to node group resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_launch_template_ids"></a> [launch\_template\_ids](#output\_launch\_template\_ids) | Launch template IDs keyed by node group name. |
| <a name="output_node_group_arns"></a> [node\_group\_arns](#output\_node\_group\_arns) | Managed node group ARNs keyed by node group name. |
| <a name="output_node_group_ids"></a> [node\_group\_ids](#output\_node\_group\_ids) | Managed node group IDs keyed by node group name. |
<!-- END_TF_DOCS -->
