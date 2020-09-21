# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "development-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR blocks for Subnet"
  default = ["10.10.100.0/24", "10.10.200.0/24", "10.10.300.0/24"]
  type = list
}