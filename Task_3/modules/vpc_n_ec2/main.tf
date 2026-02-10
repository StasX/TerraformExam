resource "aws_vpc" "exam_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name"    = "Exam VPC"
    "Created" = "Terraform"
  }
}

resource "aws_subnet" "subnets" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.exam_vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    "Name"    = "Subnet ${count.index}"
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

resource "aws_route_table" "subnet_rts" {
  count  = var.subnet_count
  vpc_id = aws_vpc.exam_vpc.id

  tags = {
    "Name"    = "RouteTable ${count.index}"
    "Created" = "Terraform"
  }
}

resource "aws_route_table_association" "subnet_rts_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.subnet_rts[count.index].id
}

resource "aws_route" "subnet_default_route" {
  count                  = var.subnet_count
  route_table_id         = aws_route_table.subnet_rts[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.exam_ig.id
}
