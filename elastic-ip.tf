resource "aws_eip" "eip1" {
  # EIP is in a VPC or not 
  vpc = true

  # EIP may require IGW to exist prior to association
  # Use depends_on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.igw]

  # A map of tags to assign to the resource
  tags = {
    Name = "eip1"
  }
}

resource "aws_eip" "eip2" {
  # EIP is in a VPC or not 
  vpc = true

  # EIP may require IGW to exist prior to association
  # Use depends_on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.igw]

  # A map of tags to assign to the resource
  tags = {
    Name = "eip2"
  }
}