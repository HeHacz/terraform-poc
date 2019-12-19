# Internet VPC
resource "aws_vpc" "poc-network" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "poc-network-${var.ENV}"
  }
}

# Subnets definition 
resource "aws_subnet" "poc-network-public-1" {
  vpc_id                  = aws_vpc.poc-network.id
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "poc-network-${var.ENV}-public-1"
  }
}

resource "aws_subnet" "poc-network-public-2" {
  vpc_id                  = aws_vpc.poc-network.id
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "poc-network-${var.ENV}-public-2"
  }
}


resource "aws_subnet" "poc-network-private-1" {
  vpc_id                  = aws_vpc.poc-network.id
  cidr_block              = "172.16.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "poc-network-${var.ENV}-private-1"
  }
}

resource "aws_subnet" "poc-network-private-2" {
  vpc_id                  = aws_vpc.poc-network.id
  cidr_block              = "172.16.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "poc-network-${var.ENV}-private-2"
  }
}



# Internet GateWay definition
resource "aws_internet_gateway" "poc-network-gw" {
  vpc_id = aws_vpc.poc-network.id

  tags = {
    Name = "poc-network-${var.ENV}"
  }
}

# route tables
resource "aws_route_table" "poc-network-public" {
  vpc_id = aws_vpc.poc-network.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc-network-gw.id
  }

  tags = {
    Name = "poc-network-${var.ENV}-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "poc-network-public-1-a" {
  subnet_id      = aws_subnet.poc-network-public-1.id
  route_table_id = aws_route_table.poc-network-public.id
}

resource "aws_route_table_association" "poc-network-public-2-a" {
  subnet_id      = aws_subnet.poc-network-public-2.id
  route_table_id = aws_route_table.poc-network-public.id
}


output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.poc-network.id
}


output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.poc-network-private-1.id, aws_subnet.poc-network-private-2.id]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.poc-network-public-1.id, aws_subnet.poc-network-public-2.id]
}