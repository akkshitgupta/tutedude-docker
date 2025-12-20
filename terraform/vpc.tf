# VPC for Part 2 --> separate EC2 Instance
resource "aws_vpc" "part-2-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "part-2-subnet-public" {
  vpc_id                  = aws_vpc.part-2-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.part-2-vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.part-2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.part-2-subnet-public.id
  route_table_id = aws_route_table.public.id
}


# VPC for Part 3 --> ECR and ECS
resource "aws_vpc" "part-3-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "part-3-subnet-public" {
  count                   = 2
  vpc_id                  = aws_vpc.part-3-vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "part-3-igw" {
  vpc_id = aws_vpc.part-3-vpc.id
}

resource "aws_route_table" "part-3-route-table" {
  vpc_id = aws_vpc.part-3-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.part-3-igw.id
  }
}

resource "aws_route_table_association" "part-3-public" {
  count          = 2
  subnet_id      = aws_subnet.part-3-subnet-public[count.index].id
  route_table_id = aws_route_table.part-3-route-table.id
}
