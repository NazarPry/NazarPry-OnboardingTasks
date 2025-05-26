variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "cluster_version" {
  default = "1.31"
}

variable "eks_node_instance_type" {
  default = "t3.small"
}