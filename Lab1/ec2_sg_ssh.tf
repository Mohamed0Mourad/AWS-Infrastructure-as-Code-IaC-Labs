#7- create ec2(bastion) in public subnet with security group from 7

resource "aws_instance" "bastion" {
  ami                    ="ami-0c55b159cbfafe1f0"
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

# 8- create ec2(application) private subnet with security group from 8a
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