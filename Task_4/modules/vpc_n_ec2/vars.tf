variable "vpc_cidr" {
  type = string
}
variable "subnet_count" {
  type = number
  validation {
    condition = var.subnet_count >= 2
    error_message = "subnet_count should be 2 or higher"
  }
}
variable "instance_type" {
  type = string
}
variable "assign_public_ip" {
  type = bool
}
variable "ami_type" {
  type = string
}
