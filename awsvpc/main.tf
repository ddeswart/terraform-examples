provider "aws" {
  version = "2.69.0"
}

# VPC resources: This will create 1 VPC with 2 Subnets, 1 Internet Gateway, 2 Route Tables.

data "aws_availability_zones" "all" {}

resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_block)

  vpc_id = aws_vpc.default.id
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_block)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_block)

  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zone

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_block)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_block)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_block)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# NAT resources: This will create 1 NAT gateways in 1 Public Subnet for 1 different Private Subnet.

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr_block)

  vpc = true
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.default]

  count = length(var.public_subnet_cidr_block)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}