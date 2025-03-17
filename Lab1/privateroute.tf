# This file is used to create a route table for the private subnet and associate it with the private subnet.
# The route table is associated with the NAT Gateway to allow the private instances to access the internet through the NAT Gateway.

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
