variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "nacl_name" {
  description = "Name prefix for VPC resources"
  type        = string
}