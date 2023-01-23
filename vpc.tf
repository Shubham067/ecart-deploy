resource "aws_vpc" "ecart_vpc" {
  # The CIDR block for the VPC
  cidr_block = "10.0.0.0/16"

  # Make instances shared on the host
  instance_tenancy = "default"

  # Required for EKS. Enable/Disable DNS support in the VPC
  enable_dns_support = true

  # Required for EKS. Enable/Disable DNS hostnames in the VPC
  enable_dns_hostnames = true

  # Enable/Disable ClassicLink for the VPC
  enable_classiclink = false

  # Enable/Disable ClassicLink DNS support for the VPC
  enable_classiclink_dns_support = false

  # Request an Amazon provided IPV6 CIDR block with a /56 prefix length for the VPC
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource
  tags = {
    Name = "ecart_vpc"
  }
}

output "vpc_id" {
  value       = aws_vpc.ecart_vpc.id
  description = "VPC id"
  # Setting an output value as sensitive prevents Terraform
  # from displaying its value in plan and apply
  sensitive = false
}