# Create IAM role for EKS node group
resource "aws_iam_role" "nodes" {
  # The name of the role
  name = "eks-node-group-nodes"

  # Policy that grants an entity permission to assume the role  
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  # The ARN of the policy we want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # The name of the IAM role to which the policy should be applied  
  role = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  # The ARN of the policy we want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # The name of the IAM role to which the policy should be applied  
  role = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # The ARN of the policy we want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # The name of the IAM role to which the policy should be applied  
  role = aws_iam_role.nodes.name
}

# Optional: only if we want to "SSH" to the EKS nodes
resource "aws_iam_role_policy_attachment" "amazon_ssm_managed_instance_core" {
  # The ARN of the policy we want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  # The name of the IAM role to which the policy should be applied  
  role = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "private_nodes" {
  # Name of the EKS Cluster
  cluster_name = aws_eks_cluster.eks.name

  # Name of the EKS Node Group  
  node_group_name = "private-nodes"

  # Amazon Resource Name (ARN) of the IAM Role that 
  # provides permissions for the EKS Node Group  
  node_role_arn = aws_iam_role.nodes.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster)  
  # Single subnet to avoid data transfer charges while testing.
  subnet_ids = [
    aws_subnet.private_ap_south_1a.id,
    aws_subnet.private_ap_south_1b.id
  ]

  # Type of capacity associated with the EKS Node Group
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # List of instance types associated with the EKS Node Group  
  instance_types = ["t3.small"]

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group
  # Valid values = AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Disk size in GiB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to 
  # be drained due to a pod disruption budget issue
  force_update_version = false

  # Configuration block with scaling settings  
  scaling_config {
    # Desired number of worker nodes  
    desired_size = 1

    # Maximum number of worker nodes
    max_size = 1

    # Minimum number of worker nodes
    min_size = 1
  }

  #   update_config {
  #     max_unavailable = 1
  #   }

  # Key-value map of Kubernetes labels  
  labels = {
    role = "general"
  }

  # Kubernetes version
  # Defaults to EKS Cluster Kubernetes version
  version = "1.24"

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}