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