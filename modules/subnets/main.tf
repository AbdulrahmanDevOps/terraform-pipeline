# Public subnets
resource "aws_subnet" "public" {
  count                   = var.az_count
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name        = "${var.subnet_name}-public-${count.index + 1}"
    AZ          = var.availability_zones[count.index]
  }
}

# Private subnets
resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + var.az_count)
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name        = "${var.subnet_name}-private-${count.index + 1}"
    AZ          = var.availability_zones[count.index]
  }
}