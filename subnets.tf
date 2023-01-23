resource "aws_subnet" "public_ap_south_1a" {
  # VPC id
  vpc_id = aws_vpc.ecart_vpc.id

  # CIDR block for the subnet
  cidr_block = "10.0.0.0/19"

  # AZ for the subnet
  availability_zone = "ap-south-1a"

  # Required for EKS. Instances launched into the 
  # subnet should be assigned a public ip address
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource
  tags = {
    "Name"                                              = "public-ap-south-1a"
    "kubernetes.io/role/elb"                            = "1"
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_ap_south_1b" {
  # VPC id
  vpc_id = aws_vpc.ecart_vpc.id

  # CIDR block for the subnet
  cidr_block = "10.0.32.0/19"

  # AZ for the subnet
  availability_zone = "ap-south-1b"

  # Required for EKS. Instances launched into the 
  # subnet should be assigned a public ip address
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource
  tags = {
    "Name"                                              = "public-ap-south-1b"
    "kubernetes.io/role/elb"                            = "1"
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_ap_south_1a" {
  # VPC id
  vpc_id = aws_vpc.ecart_vpc.id

  # CIDR block for the subnet
  cidr_block = "10.0.64.0/19"

  # AZ for the subnet
  availability_zone = "ap-south-1a"

  # A map of tags to assign to the resource
  tags = {
    "Name"                                              = "private-ap-south-1a"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_ap_south_1b" {
  # VPC id
  vpc_id = aws_vpc.ecart_vpc.id

  # CIDR block for the subnet
  cidr_block = "10.0.96.0/19"

  # AZ for the subnet
  availability_zone = "ap-south-1b"

  # A map of tags to assign to the resource
  tags = {
    "Name"                                              = "private-ap-south-1b"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"
  }
}