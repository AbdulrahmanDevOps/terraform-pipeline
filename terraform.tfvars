aws_region          = "us-east-1"

name                = "main-vpc"

default_tags        = {
                        ManagedBy   = "MyTeam"
                        Environment = "Dev"
                        Project     = "TerraformDemo"
                        }

az_count            = 6

vpc_cidr            = "10.0.0.0/24"

ssh_cidr            = [ "0.0.0.0/0" ]

enable_nat_gateway  = true

single_nat_gateway  = true
