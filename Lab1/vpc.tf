resource "aws_vpc" "labvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "LabVPC"
  }
}