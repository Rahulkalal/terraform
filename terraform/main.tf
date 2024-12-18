provider "aws" {
  region = "us-east-1"  # AWS region
}

# Create a VPC (Virtual Private Cloud)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway to allow the VPC to connect to the internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create a subnet within the VPC
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"  # Correct the availability zone to match the region
}

# Create a security group (firewall) allowing SSH and HTTP
resource "aws_security_group" "allow_ssh_http" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }
}

