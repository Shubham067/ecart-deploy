resource "aws_route_table_association" "public_ap_south_1a" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_ap_south_1a.id

  # The ID of the routing table to associate with
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_ap_south_1b" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_ap_south_1b.id

  # The ID of the routing table to associate with
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_ap_south_1a" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_ap_south_1a.id

  # The ID of the routing table to associate with
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private_ap_south_1b" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_ap_south_1b.id

  # The ID of the routing table to associate with
  route_table_id = aws_route_table.private2.id
}