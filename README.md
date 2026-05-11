# tf-infra-eks-modules
My EKS provisioning lab with Terraform (under construction!)

# References
https://www.udemy.com/course/terraform-para-aws

https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html

https://docs.aws.amazon.com/eks/latest/userguide/network-reqs.html

https://github.com/antonputra/tutorials/tree/main/lessons/195

https://github.com/kenerry-serain/devops-na-nuvem-week-03-iac

https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.44.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 3.1.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 3.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_eks_aws_addons"></a> [eks\_aws\_addons](#module\_eks\_aws\_addons) | ./modules/cluster-addons | n/a |
| <a name="module_eks_aws_load_balancer_controller"></a> [eks\_aws\_load\_balancer\_controller](#module\_eks\_aws\_load\_balancer\_controller) | ./modules/aws-load-balancer-controller | n/a |
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | ./modules/cluster | n/a |
| <a name="module_eks_managed_node_group"></a> [eks\_managed\_node\_group](#module\_eks\_managed\_node\_group) | ./modules/managed-node-group | n/a |
| <a name="module_eks_metrics_server"></a> [eks\_metrics\_server](#module\_eks\_metrics\_server) | ./modules/metrics-server | n/a |
| <a name="module_eks_network"></a> [eks\_network](#module\_eks\_network) | ./modules/network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | Map of IAM principals to grant access to the EKS cluster | <pre>map(object({<br/>    principal_arn     = string<br/>    type              = optional(string, "STANDARD")<br/>    kubernetes_groups = optional(list(string))<br/>    policy_associations = optional(map(object({<br/>      policy_arn = string<br/>      access_scope = object({<br/>        type       = string<br/>        namespaces = optional(list(string), [])<br/>      })<br/>    })), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_addon_cni_version"></a> [addon\_cni\_version](#input\_addon\_cni\_version) | VPC CNI addon version | `string` | n/a | yes |
| <a name="input_addon_coredns_version"></a> [addon\_coredns\_version](#input\_addon\_coredns\_version) | CoreDNS addon version | `string` | n/a | yes |
| <a name="input_addon_kubeproxy_version"></a> [addon\_kubeproxy\_version](#input\_addon\_kubeproxy\_version) | Kube-Proxy addon version | `string` | n/a | yes |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | AMI type | `string` | `"AL2023_x86_64_STANDARD"` | no |
| <a name="input_auto_scale_options"></a> [auto\_scale\_options](#input\_auto\_scale\_options) | Cluster Autoscaling Settings | <pre>object({<br/>    min     = number<br/>    max     = number<br/>    desired = number<br/>  })</pre> | <pre>{<br/>  "desired": 1,<br/>  "max": 1,<br/>  "min": 1<br/>}</pre> | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Capacity type | `string` | `"ON_DEMAND"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | Networking CIDR block to be used for the VPC | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Cluster Version | `string` | `"1.35"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size | `string` | `"100"` | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Endpoint private access | `string` | `"true"` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Endpoint public access | `string` | `"true"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Instance types | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name to be used to name the resources (Name tag) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create the resources | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all AWS resources | `map(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
