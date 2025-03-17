# Description: This file creates a NAT Gateway in the public subnet
# and associates the EIP created in the previous step to the NAT Gateway.
# The NAT Gateway is created in the public subnet to allow the private
# instances to access the internet through the NAT Gateway.
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "MainNATGateway"
  }
}
