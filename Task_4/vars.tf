# access variables
variable "AWS_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_type" {
  type        = string
  default = "ami-0801976e993cd4ddf"
}
variable "instance_type" {
  type = string
  default = "t3.micro"
}