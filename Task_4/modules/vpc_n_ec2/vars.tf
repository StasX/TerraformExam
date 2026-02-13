variable "vpc_cidr" {
  type = string
  validation {
    condition     = can(regex("^\\d{1,3}(\\.\\d{1,3}){3}/\\d{1,2}$", var.vpc_cidr))
    error_message = "vpc_cidr should be IP"
  }
}

variable "subnet_count" {
  type = number
  validation {
    condition     = var.subnet_count >= 2 && var.subnet_count <= 4
    error_message = "subnet_count should be 2 or higher"
  }
}

variable "instance_type" {
  type = string
  validation {
    condition = can(regex(
      "^(t|m|c|r|a|z|i|d|p|g|f|inf|x)[0-9][a-z0-9]*(\\.[a-z0-9]+)?$",
      var.instance_type
    ))
    error_message = "Invalid instance type."
  }
}

variable "assign_public_ip" {
  type = bool
}

variable "ami_type" {
  type = string
  validation {
    condition     = can(regex("^ami-[a-f0-9]{8,17}$", var.ami_type))
    error_message = "Invalid AMI"
  }
}

variable "az" {
  type = list(string)
}

variable "region_type" {
  type = string
  validation {
    condition = can(regex(
      "^(us|eu|ap|sa|ca|me|af)-(north|south|east|west|central|southeast|northeast|southwest)-[0-9]$",
      var.region_type
    ))
    error_message = "Invalid region"
  }
}
