variable "vpc_cidr_block" {
  default = "10.7.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.7.1.0/24"
}

variable "subnet_type" {
  type = string

  validation {
    condition     = contains(["public", "private"], var.subnet_type)
    error_message = "value should be either public or private"
  }
}

variable "route-table-name" {
  type = string
}

variable "igw-name" {
  type    = string
  default = "my-igw"
}

variable "vpc-name" {
  type = string
}