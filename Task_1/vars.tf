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
