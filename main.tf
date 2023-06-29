locals {
  name                = "aws-ebs-csi-driver"
  cluster_oidc_issuer = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.10.1"

  create_role = true

  role_name = local.name

  tags = var.tags

  provider_url     = local.cluster_oidc_issuer
  role_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
}


resource "helm_release" "ebs_csi_driver" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = "2.16.0"
  namespace  = "kube-system"
  values = concat([
    yamlencode({
      controller : {
        serviceAccount : {
          annotations : {
            "eks.amazonaws.com/role-arn" : module.iam_role.iam_role_arn
          }
        }
      }
    })
  ], var.chart_values)
}
