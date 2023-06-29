# AWS EKS EBS CSI Terraform module
A Terraform module which deploy AWS EBS CSI on your EKS cluster.
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

## Example
```hcl
module "ebs_csi" {
  source  = "blackbird-cloud/eks-ebs-csi/aws"
  version = "0.0.1"

  cluster_name = var.eks_cluster_name
  tags         = {}
  aws_region   = var.aws_region
  aws_profile  = var.aws_profile
  chart_values = [
    yamlencode({
      node : {
        tolerations : [
          { key : "application-node", value : "true", effect : "NO_SCHEDULE" }
        ]
      },
      storageClasses : [
        {
          name : "gp3",
          annotations : {
            "storageclass.kubernetes.io/is-default-class" : "true"
          }
          allowVolumeExpansion : true
          volumeBindingMode : "WaitForFirstConsumer"
          reclaimPolicy : "Retain"
          parameters : {
            type : "gp3"
          }
        }
      ]
    })
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.15.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.15.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.4.1 |

## Resources

| Name | Type |
|------|------|
| [helm_release.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/2.4.1/docs/resources/release) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/4.15.1/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/4.15.1/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS Profile | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_chart_values"></a> [chart\_values](#input\_chart\_values) | Chart values addon | `list(any)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for deployment | `map(string)` | n/a | yes |

## Outputs

No outputs.

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)
