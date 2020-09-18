variable "region" {
  default     = "eu-central-1"
  type        = string
  description = "Region of the VPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  default     = "10.0.100.0/24"
  type        = string
  description = "Public subnet CIDR block"
}

variable "private_subnet_cidr_block" {
  default     = "10.0.200.0/24"
  type        = string
  description = "Private subnet CIDR block"
}

variable "availability_zone" {
  default     = "eu-central-1c"
  type        = string
  description = "Availability zone"
}