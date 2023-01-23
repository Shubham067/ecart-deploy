resource "aws_internet_gateway" "igw" {
  # The VPC ID to create in
  vpc_id = aws_vpc.ecart_vpc.id

  # A map of tags to assign to the resource
  tags = {
    Name = "ecart_internet_gateway"
  }
}