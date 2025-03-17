resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.labvpc.id

  tags = {
    Name = "LabInternetGateway"
  }
}
