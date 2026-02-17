#########################################
# Data Sources
#########################################

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

#########################################
# Locals (AZ Validation)
#########################################

locals {
  available_az_count = length(data.aws_availability_zones.available.names)

  validate_az_count = (
    var.az_count <= local.available_az_count
    ? true
    : error("Region ${data.aws_region.current.id} supports only ${local.available_az_count} Availability Zones. You selected ${var.az_count}.")
  )
}

locals {
  selected_azs = slice(
    data.aws_availability_zones.available.names,
    0,
    min(var.az_count, local.available_az_count)
  )
}
############################################
# Create VPC
############################################
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  vpc_name     = var.name
  az_count     = var.az_count
}

############################################
# Create Subnets
############################################
module "subnets" {
  source             = "./modules/subnets"
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr_block
  subnet_name        = var.name
  az_count           = var.az_count
  availability_zones = local.selected_azs
}

############################################
# Create Internet Gateway
############################################
module "internet_gateway" {
  source       = "./modules/internet_gateway"
  vpc_id       = module.vpc.vpc_id
  igw_name     = var.name
}

############################################
# Create NAT Gateway
############################################
module "nat_gateway" {
  source              = "./modules/nat_gateway"
  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  az_count            = var.az_count
  public_subnet_ids   = module.subnets.public_subnet_ids
  nat_name            = var.name
  internet_gateway    = module.internet_gateway.igw_id
}

############################################
# Create Route Tables
############################################
module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.igw_id
  single_nat_gateway  = var.single_nat_gateway
  nat_gateway_ids     = module.nat_gateway.nat_gateway_ids
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  availability_zones  = local.selected_azs
  az_count            = var.az_count
  rt_name             = var.name
}

############################################
#Create Security Group
############################################
module "security_group" {
  source    = "./modules/security_group"
  vpc_id    = module.vpc.vpc_id
  sg_name   = var.name
  ssh_cidr  = var.ssh_cidr
}

############################################
#Create NACL (Network Access Control List)
############################################
module "nacl" {
  source     = "./modules/nacl"
  nacl_name  = var.name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.subnets.public_subnet_ids
}
