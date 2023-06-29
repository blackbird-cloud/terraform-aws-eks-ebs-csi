variable "aws_profile" {
  type        = string
  description = "AWS Profile"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "tags" {
  type        = map(string)
  description = "Tags for deployment"
}

variable "chart_values" {
  type        = list(any)
  description = "Chart values addon"
  default     = []
}
