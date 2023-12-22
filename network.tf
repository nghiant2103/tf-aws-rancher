# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet_01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_01_cidr_block
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-01"
  }
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_01_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-01"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_02_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-02"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# Create the Public Route Table for Public Subnet
resource "aws_route_table" "public_rtb_01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rtb-01"
  }
}

# Associate the Public Route Table with the Public Subnet
resource "aws_route_table_association" "public_rtb_01_association" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.public_rtb_01.id
}

# Create the Private Route Table for Private Subnet
resource "aws_route_table" "private_rtb_01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rtb-01"
  }
}

# Associate the Private Route Table with the Private Subnet
resource "aws_route_table_association" "private_rtb_01_association" {
  subnet_id      = aws_subnet.private_subnet_01.id
  route_table_id = aws_route_table.private_rtb_01.id
}

# Create the Private Route Table for Private Subnet
resource "aws_route_table" "private_rtb_02" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rtb-02"
  }
}

# Associate the Private Route Table with the Private Subnet
resource "aws_route_table_association" "private_rtb_02_association" {
  subnet_id      = aws_subnet.private_subnet_02.id
  route_table_id = aws_route_table.private_rtb_02.id
}
