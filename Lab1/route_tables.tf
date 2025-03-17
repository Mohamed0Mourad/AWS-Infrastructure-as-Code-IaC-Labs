#public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.labvpc.id

  tags = {
    Name = "PublicRouteTable"
  }
}
#private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.labvpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}
