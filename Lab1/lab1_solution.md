

## Code Snippets

### Provider Configuration
```hcl
provider "aws" {
  region  = "us-east-1"
  profile = "terraformuser"
}
```

### VPC Creation
```hcl
resource "aws_vpc" "labvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "LabVPC"
  }
}
```

### Internet Gateway Creation
```hcl
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.labvpc.id

  tags = {
    Name = "LabInternetGateway"
  }
}
```

### Public Subnets Creation
```hcl
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.labvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.labvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "PublicSubnet2"
  }
}
```

### Private Subnets Creation
```hcl
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.labvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.labvpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet2"
  }
}
```

### NAT Gateway and Elastic IP Creation
```hcl
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "MainNATGateway"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP"
  }
}
```

### Security Groups Creation
```hcl
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.labvpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_ssh_p3000" {
  name        = "allow_ssh_p3000"
  description = "Allow SSH and port 3000 from VPC CIDR"
  vpc_id      = aws_vpc.labvpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.labvpc.cidr_block]
  }

  ingress {
    description = "Port 3000 from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.labvpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_p3000"
  }
}
```

### EC2 Instances Creation
```hcl
resource "aws_instance" "bastion" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = "lab3"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "bastion-host"
  }

  root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

resource "aws_instance" "application" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  key_name               = "lab3"
  vpc_security_group_ids = [aws_security_group.allow_ssh_p3000.id]

  tags = {
    Name = "application-server"
  }

  root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    delete_on_termination = true
  }
}
```




