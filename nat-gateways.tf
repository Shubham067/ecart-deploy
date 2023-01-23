resource "aws_nat_gateway" "nat1" {
  # The Allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.eip1.id

  # The Subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_ap_south_1a.id

  # A map of tags to assign to the resource
  tags = {
    Name = "nat1"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat2" {
  # The Allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.eip2.id

  # The Subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_ap_south_1b.id

  # A map of tags to assign to the resource
  tags = {
    Name = "nat2"
  }

  depends_on = [aws_internet_gateway.igw]
}