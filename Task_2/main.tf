resource "aws_vpc" "exam_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name"    = "Exam VPC"
    "Created" = "Terraform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.exam_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = {
    "Name"    = "Public Subnet"
    "Created" = "Terraform"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.exam_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}a"
  tags = {
    "Name"    = "Private Subnet"
    "Created" = "Terraform"
  }
}

resource "aws_internet_gateway" "exam_ig" {
  vpc_id = aws_vpc.exam_vpc.id
  tags = {
    "Name"    = "Internet Gateway"
    "Created" = "terraform"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.exam_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.exam_ig.id
  }

  tags = {
    "Name"    = "Public Route Table"
    "Created" = "Terraform"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.exam_vpc.id

  tags = {
    "Name"    = "Private Route Table"
    "Created" = "Terraform"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
