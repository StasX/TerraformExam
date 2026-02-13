variable "vpc_cidr" {
  type = string
  validation {
    condition     = can(regex("^[0-9]{1,3}(\\.[0-9]{1,3}){3}$", var.vpc_cidr))
    error_message = "vpc_cidr should be IP"
  }
}

variable "subnet_count" {
  type = number
  validation {
    condition     = var.subnet_count > 0
    error_message = "subnet_count should be higher than 0"
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

variable "region" {
  type = string
  validation {
    condition = can(regex(
      "^(us|eu|ap|sa|ca|me|af)-(north|south|east|west|central|southeast|northeast|southwest)-[0-9]$",
      var.region
    ))
    error_message = "Invalid region"
  }
}
