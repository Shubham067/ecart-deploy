resource "aws_iam_role" "eks_cluster_role" {
  # The name of the role
  name = "eks-cluster-role"

  # Policy that grants an entity permission to assume the role
  # Used to access AWS resources that one might not have access to
  # The role that Amazon EKS will use to create AWS resources for
  # Kubernetes clusters
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # The ARN of the policy we want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The name of the IAM role to which the policy should be applied
  role = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "eks" {
  # Name of the cluster
  name = "eks"

  # Desired Kubernetes master version
  version = "1.24"

  # The Amazon Resource Name(ARN) of the IAM role that provides permissions for 
  # the Kubernetes control plane to make calls to AWS API operations on your behalf  
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = false

    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access = true

    # List of subnet IDs
    # Must be in at least two different availability zones
    subnet_ids = [
      aws_subnet.private_ap_south_1a.id,
      aws_subnet.private_ap_south_1b.id,
      aws_subnet.public_ap_south_1a.id,
      aws_subnet.public_ap_south_1b.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups  
  depends_on = [aws_iam_role_policy_attachment.amazon_eks_cluster_policy]
}