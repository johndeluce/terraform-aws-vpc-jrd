# Unit tests
run "vpc_minimal_configuration" {
  command = plan
  variables {
    vpc_name             = "test-vpc-minimal"
    vpc_cidr             = "10.0.0.0/16"
    availability_zones   = ["us-west-1a"]
    public_subnet_cidrs  = ["10.0.1.0/24"]
    private_subnet_cidrs = ["10.0.2.0/24"]
    enable_nat_gateway   = true
    single_nat_gateway   = true
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        Environment = "test"
    }
  }

  assert {
    condition = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block should be 10.0.0.0/16"
  }

  assert {
    condition = aws_vpc.main.enable_dns_hostnames == true
    error_message = "DNS hostnames should be enabled"
  }

    assert {
    condition     = aws_vpc.main.enable_dns_support == true
    error_message = "DNS support should be enabled"
  }
  assert {
    condition     = length(aws_subnet.public) == 1
    error_message = "Should have exactly 1 public subnet"
  }
  assert {
    condition     = length(aws_subnet.private) == 1
    error_message = "Should have exactly 1 private subnet"
  }
}

run "multi_az_deployment" {
    command = plan
    variables {
        vpc_name             = "test-vpc-minimal"
        vpc_cidr             = "10.0.0.0/16"
        availability_zones   = ["us-west-1a", "us-west-1b"]
        public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
        private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
        enable_nat_gateway   = true
        single_nat_gateway   = false
        enable_dns_hostnames = true
        enable_dns_support   = true
        tags = {
            Environment = "test"
        }
    }
    assert {
      condition = length(aws_subnet.public) == 2
      error_message = "Should have exactly 2 public subnets"
    }
    assert {
      condition = length(aws_subnet.private) == 2
      error_message = "Should have exactly 2 private subnets"
    }
    assert {
      condition = aws_subnet.public[0].availability_zone == "us-west-1a"
      error_message = "First public subnet should be in availability zone 'us-west-1a'"
    }
    assert {
      condition = aws_subnet.public[1].availability_zone == "us-west-1b"
      error_message = "Second public subnet should be in availability zone 'us-west-1b'"
    }
    assert {
      condition = aws_subnet.private[0].availability_zone == "us-west-1a"
      error_message = "First private subnet should be in availability zone 'us-west-1a'"
    }
    assert {
      condition = aws_subnet.private[1].availability_zone == "us-west-1b"
      error_message = "Second private subnet should be in availability zone 'us-west-1b'"
    }
    assert {
      condition = aws_subnet.public[0].cidr_block != aws_subnet.public[1].cidr_block
      error_message = "Public subnets should have different CIDR blocks"
    }
    assert {
      condition = aws_subnet.private[0].cidr_block != aws_subnet.private[1].cidr_block
      error_message = "Private subnets should have different CIDR blocks"
    }
}