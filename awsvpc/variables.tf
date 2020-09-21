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