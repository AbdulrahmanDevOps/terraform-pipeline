variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name prefix for VPC resources"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
}