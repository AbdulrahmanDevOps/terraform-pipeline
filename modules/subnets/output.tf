# Required for NAT, route tables, NACL
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

# Optional (for AZ mapping visibility)
output "public_subnets_by_az" {
  description = "Public subnets mapped by AZ"
  value = {
    for i, az in var.availability_zones :
    az => aws_subnet.public[i].id
  }
}

output "private_subnets_by_az" {
  description = "Private subnets mapped by AZ"
  value = {
    for i, az in var.availability_zones :
    az => aws_subnet.private[i].id
  }
}

