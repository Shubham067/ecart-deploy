resource "aws_route_table" "public" {
  # The VPC ID
  vpc_id = aws_vpc.ecart_vpc.id

  # A list of route objects
  route {
    # CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway 
    # or a virtual private gateway
    gateway_id = aws_internet_gateway.igw.id
  }

  # A map of tags to assign to the resource
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  # The VPC ID
  vpc_id = aws_vpc.ecart_vpc.id

  # A list of route objects
  route {
    # CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC NAT gateway
    nat_gateway_id = aws_nat_gateway.nat1.id
  }

  # A map of tags to assign to the resource
  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  # The VPC ID
  vpc_id = aws_vpc.ecart_vpc.id

  # A list of route objects
  route {
    # CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC NAT gateway
    nat_gateway_id = aws_nat_gateway.nat2.id
  }

  # A map of tags to assign to the resource
  tags = {
    Name = "private2"
  }
}