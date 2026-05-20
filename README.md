<!-- Module Documentation -->
# Created by: John DeLuce

## Documentation
### Network Architecture
- Configurable VPC CIDR block
- Variable number of public subnets across multiple availability zones
- Variable number of private subnets across multiple availability zones
- Internet Gateway for public subnet connectivity
- NAT Gateway(s) for private subnet internet access
- Appropriate route tables and associations
### Variables
- vpc_name
- vpc_cidr
- availability_zones
- public_subnet_cidrs
- private_subnet_cidrs
- enable_nat_gateway
- single_nat_gateway
- enable_dns_hostnames
- enable_dns_support
- tags

### Outputs
- vpc_id
- vpc_cidr_block
- public_subnet_ids
- private_subnet_ids
- nat_gateway_ids
- internet_gateway_id
- public_route_table_ids
- private_route_table_ids
  