variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g., '10.0.0.0/16')"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block (e.g., '10.0.0.0/16')."
  }
}

variable "availability_zones" {
  description = "List of AZs to use (e.g., ['us-east-1a', 'us-east-1b'])"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets, one per AZ"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets, one per AZ"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Boolean to enable/disable NAT gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use one NAT gateway for all AZs (cost saving) vs one per AZ (high availability)"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Boolean to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Boolean to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of common tags to apply to all resources"
  type        = map(string)
  default     = {}
}