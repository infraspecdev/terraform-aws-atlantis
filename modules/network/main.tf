provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = local.vpc_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.igw_name
  }
}


resource "aws_route" "public_1" {
  route_table_id         = aws_route_table.public_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_subnet" "public_1" {
  cidr_block        = var.public_subnet_cidrs[0]
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[1]
  tags = {
    Name = local.public_1_subnet_name
  }
}

resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.public_1_route_table_name
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}

resource "aws_route" "public_2" {
  route_table_id         = aws_route_table.public_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_subnet" "public_2" {
  cidr_block        = var.public_subnet_cidrs[1]
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[1]
  tags = {
    Name = local.public_2_subnet_name
  }
}

resource "aws_route_table" "public_2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.public_2_route_table_name
  }
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_2.id
}

resource "aws_subnet" "private_1" {
  cidr_block        = var.private_subnet_cidrs[0]
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[0]
  tags = {
    Name = local.private_1_subnet_name
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.private_1_route_table_name
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}


resource "aws_subnet" "private_2" {
  cidr_block        = var.private_subnet_cidrs[1]
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[0]
  tags = {
    Name = local.private_2_subnet_name
  }
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.private_2_route_table_name
  }
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}
