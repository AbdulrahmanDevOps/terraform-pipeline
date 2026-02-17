variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name prefix for subnet resources"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones"
  type        = number
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}