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
| <a name="module_eks_aws_addons"></a> [eks\_aws\_addons](#module\_eks\_aws\_addons) | ./modules/eks-aws-addons | n/a |
| <a name="module_eks_aws_lb_controller"></a> [eks\_aws\_lb\_controller](#module\_eks\_aws\_lb\_controller) | ./modules/aws-lb-controller | n/a |
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | ./modules/cluster | n/a |
| <a name="module_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#module\_eks\_cluster\_autoscaler) | ./modules/cluster-autoscaler | n/a |
| <a name="module_eks_kube_state_metrics"></a> [eks\_kube\_state\_metrics](#module\_eks\_kube\_state\_metrics) | ./modules/kube-state-metrics | n/a |
| <a name="module_eks_managed_node_group"></a> [eks\_managed\_node\_group](#module\_eks\_managed\_node\_group) | ./modules/managed-node-group | n/a |
| <a name="module_eks_metrics_server"></a> [eks\_metrics\_server](#module\_eks\_metrics\_server) | ./modules/metrics-server | n/a |
| <a name="module_eks_network"></a> [eks\_network](#module\_eks\_network) | ./modules/network | n/a |
| <a name="module_eks_velero"></a> [eks\_velero](#module\_eks\_velero) | ./modules/velero | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | Map of IAM principals to grant access to the EKS cluster | <pre>map(object({<br/>    principal_arn     = string<br/>    type              = optional(string, "STANDARD")<br/>    kubernetes_groups = optional(list(string))<br/>    policy_associations = optional(map(object({<br/>      policy_arn = string<br/>      access_scope = object({<br/>        type       = string<br/>        namespaces = optional(list(string), [])<br/>      })<br/>    })), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_addon_cni_version"></a> [addon\_cni\_version](#input\_addon\_cni\_version) | VPC CNI addon version | `string` | n/a | yes |
| <a name="input_addon_coredns_version"></a> [addon\_coredns\_version](#input\_addon\_coredns\_version) | CoreDNS addon version | `string` | n/a | yes |
| <a name="input_addon_ebs_csi_version"></a> [addon\_ebs\_csi\_version](#input\_addon\_ebs\_csi\_version) | EBS CSI addon version | `string` | n/a | yes |
| <a name="input_addon_kubeproxy_version"></a> [addon\_kubeproxy\_version](#input\_addon\_kubeproxy\_version) | Kube-Proxy addon version | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | Networking CIDR block to be used for the VPC | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Cluster Version | `string` | `"1.35"` | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Endpoint private access | `string` | `"true"` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Endpoint public access | `string` | `"true"` | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of EKS managed node groups and their individual launch template, scaling, labels, taints and tags settings. | <pre>map(object({<br/>    min_size               = number<br/>    max_size               = number<br/>    desired_size           = number<br/>    create_launch_template = optional(bool, true)<br/>    launch_template_name   = optional(string)<br/>    ami_type               = optional(string, "AL2023_x86_64_STANDARD")<br/>    instance_types         = list(string)<br/>    capacity_type          = optional(string, "ON_DEMAND")<br/>    max_pods               = optional(number, 110)<br/><br/>    block_device_mappings = optional(map(object({<br/>      device_name = string<br/>      ebs = object({<br/>        volume_size           = number<br/>        volume_type           = optional(string, "gp3")<br/>        iops                  = optional(number, 3000)<br/>        throughput            = optional(number, 150)<br/>        encrypted             = optional(bool, true)<br/>        delete_on_termination = optional(bool, true)<br/>        kms_key_id            = optional(string)<br/>      })<br/>    })), {})<br/><br/>    labels = optional(map(string), {})<br/><br/>    taints = optional(list(object({<br/>      effect = string<br/>      key    = string<br/>      value  = optional(string)<br/>    })), [])<br/><br/>    tags = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of VPC Private Subnets | <pre>list(object({<br/>    name              = string<br/>    cidr              = string<br/>    availability_zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name to be used to name the resources (Name tag) | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of VPC Public Subnets | <pre>list(object({<br/>    name              = string<br/>    cidr              = string<br/>    availability_zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create the resources | `string` | `"us-east-1"` | no |
| <a name="input_service_ipv4_cidr"></a> [service\_ipv4\_cidr](#input\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes pod and service IP addresses | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all AWS resources | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_managed_node_group_arns"></a> [managed\_node\_group\_arns](#output\_managed\_node\_group\_arns) | Managed node group ARNs keyed by node group name. |
| <a name="output_managed_node_group_ids"></a> [managed\_node\_group\_ids](#output\_managed\_node\_group\_ids) | Managed node group IDs keyed by node group name. |
| <a name="output_managed_node_group_launch_template_ids"></a> [managed\_node\_group\_launch\_template\_ids](#output\_managed\_node\_group\_launch\_template\_ids) | Launch template IDs keyed by node group name. |
<!-- END_TF_DOCS -->
