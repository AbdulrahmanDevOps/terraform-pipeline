variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "Name of VPC"
  type        = string
}

variable "default_tags" {
  description = "Map of default tags to apply to all resources"
  type        = map(string)
  default     = {
    ManagedBy = "AutoCloud"
  }
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number

  validation {
    condition     = var.az_count > 0
    error_message = "az_count must be greater than 0."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
   validation {
    condition     = tonumber(split("/", var.vpc_cidr)[1]) <= 24
    error_message = "VPC CIDR must be /24 or larger (example: /16, /20, /24). Smaller networks like /25 are not allowed."
  }
}

variable "ssh_cidr" {
  type        = list(string)
  description = "ssh cidr block"
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway for all private subnets"
  type        = bool
}