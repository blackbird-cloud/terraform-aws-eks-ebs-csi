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
