
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.region
}

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
  tags = {
    "Name"    = "Public Subnet"
    "Created" = "Terraform"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.exam_vpc.id
  cidr_block = "10.0.2.0/24"
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
