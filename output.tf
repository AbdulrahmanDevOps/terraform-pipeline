output "availability_zones" {
  value = slice(
    data.aws_availability_zones.available.names,
    0,
    min(var.az_count, local.available_az_count)
  )
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets_by_az" {
  value = module.subnets.public_subnets_by_az
}

output "private_subnets_by_az" {
  value = module.subnets.private_subnets_by_az
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.internet_gateway.igw_id
}

output "public_route_table_id" {
  description = "ID of public route table"
  value       = module.route_table.public_route_table_id
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways"
  value       = var.enable_nat_gateway ? module.nat_gateway.nat_gateway_ids : []
}

output "private_route_tables_by_az" {
  description = "Private route tables mapped by AZ"
  value       = module.route_table.private_route_tables_by_az
}

output "nacl_id" {
  value = module.nacl.nacl_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}