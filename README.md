#  AWS Infrastructure as Code (IaC) Labs

This repository contains the infrastructure as code (IaC) for deploying AWS resources using Terraform. The labs are divided into two parts, each focusing on different aspects of AWS infrastructure setup and Terraform best practices.

---

## Lab 1: Basic AWS Infrastructure Setup

### Overview
In this lab, you will create a basic AWS infrastructure setup using Terraform. The infrastructure includes:
- A VPC
- Internet Gateway
- Public and Private Route Tables
- Subnets (Public and Private)
- Security Groups
- EC2 Instances (Bastion Host and Application Server)

### Steps
1. **Configure AWS Provider**: Define the AWS provider with the desired region and profile.
2. **Create VPC**: Define a VPC with a specified CIDR block.
3. **Create Internet Gateway**: Attach an Internet Gateway to the VPC.
4. **Create Public Subnets**: Create two public subnets in different availability zones.
5. **Create Private Subnets**: Create two private subnets in different availability zones.
6. **Create Public Route Table**: Define a route table for public subnets.
7. **Create Private Route Table**: Define a route table for private subnets.
8. **Create NAT Gateway and Elastic IP**: Create a NAT Gateway and associate it with an Elastic IP.
9. **Create Public Route**: Add a route to the public route table for internet access.
10. **Create Private Route**: Add a route to the private route table for internet access through the NAT Gateway.
11. **Attach Public Route Table to Subnets**: Associate the public route table with public subnets.
12. **Create Security Group (Allow SSH from 0.0.0.0/0)**: Define a security group that allows SSH access from any IP.
13. **Create Security Group (Allow SSH and Port 3000 from VPC CIDR)**: Define a security group that allows SSH and port 3000 access only from within the VPC.
14. **Create EC2 (Bastion) in Public Subnet**: Launch a bastion host in the public subnet with the security group created in step 12.
15. **Create EC2 (Application) in Private Subnet**: Launch an application server in the private subnet with the security group created in step 13.

---


## Lab 2: Advanced Terraform Practices and Multi-Environment Setup

### Overview
In this lab, you will refactor the Terraform code from Lab 1 to follow best practices and set up a multi-environment infrastructure. The lab includes:
- Using variables to make the code reusable.
- Creating subnets and EC2 instances using loops.
- Setting up different environments (dev and prod) using workspaces.
- Deploying infrastructure in multiple AWS regions.
- Adding an RDS (MySQL) and ElastiCache (Redis) instance in the private subnet.

### Steps
1. **Restructure Code to Use Variables**: Replace hardcoded values with variables for better reusability.
2. **Create All Subnets with Single Resource Using `for_each`**: Use `for_each` to create multiple subnets dynamically.
3. **Conditional Subnet Resource**: Add a condition to control `map_public_ip_on_launch` based on subnet type (public or private).
4. **Create All EC2s with Single Resource Using `count`**: Use `count` to create multiple EC2 instances.
5. **Create Two Workspaces (dev and prod)**: Set up Terraform workspaces for managing different environments.
6. **Create Two Variable Definition Files (.tfvars)**: Define environment-specific variables in `dev.tfvars` and `prod.tfvars`.
7. **Apply Code to Create Two Environments**: Deploy infrastructure in `us-east-1` (dev) and `eu-central-1` (prod).
8. **Run `local-exec` Provisioner**: Print the public IP of the bastion EC2 instance using a `local-exec` provisioner.
9. **Upload Infrastructure Code to GitHub**: Push the Terraform code to this GitHub repository.
10. **Create RDS (MySQL) in Private Subnet**: Launch an RDS MySQL instance in the private subnet.
11. **Create ElastiCache (Redis) in Private Subnet**: Launch an ElastiCache Redis instance in the private subnet.

---


---

## Prerequisites

- **Terraform Installed**: Ensure Terraform is installed on your local machine. Download it from [here](https://www.terraform.io/downloads.html).
- **AWS CLI Configured**: Ensure your AWS CLI is configured with the necessary credentials. Run `aws configure` to set up.
- **Git Installed**: Ensure Git is installed for version control.

