run "cidr_block_match"  {
  command = plan

  variables {
    region        = "ap-south-1"
    vpc_cidr_block = "10.0.0.0/16"

    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
  }

  module {
    source = "./modules/network/"
  }

  assert {
    condition     = aws_vpc.main.cidr_block == var.vpc_cidr_block
    error_message = "VPC CIDR block mismatch after creation"
  }
}

run "tags_match" {
  command = plan

  variables {
    region            = "ap-south-1"
    vpc_cidr_block    = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
    expected_tag_value = "atlantis-ecs-vpc"
  }

  module {
    source = "./modules/network/"
  }

  assert {
condition = aws_vpc.main.tags["Name"] == var.expected_tag_value
    error_message = "Tags mismatch after creation"
  }
}


run "public_1_subnet_cidr_match"  {
  command = plan

  variables {
    region        = "ap-south-1"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
  }

  module {
    source = "./modules/network/"
  }

  assert {
    condition     = aws_subnet.public_1.cidr_block == var.public_subnet_cidrs[0]
    error_message = "Public Subnet 1 CIDR block mismatch after creation"
  }
}

run "public_2_subnet_cidr_match" {
  command = plan

  variables {
    region        = "ap-south-1"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
  }

  module {
    source = "./modules/network/"
  }

  assert {
    condition     = aws_subnet.public_2.cidr_block == var.public_subnet_cidrs[1]
    error_message = "Public Subnet 2 CIDR block mismatch after creation"
  }
}

run "private_1_subnet_cidr_match"  {
  command = plan

  variables {
    region        = "ap-south-1"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
  }

  module {
    source = "./modules/network/"
  }

  assert {
    condition     = aws_subnet.private_1.cidr_block == var.private_subnet_cidrs[0]
    error_message = "Private Subnet 1 CIDR block mismatch after creation"
  }
}

run "private_2_subnet_cidr_match" {
  command = plan

  variables {
    region        = "ap-south-1"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["ap-south-1a", "ap-south-1b"]
  }

  module {
    source = "./modules/network/"
  }

  assert {
    condition     = aws_subnet.private_2.cidr_block == var.private_subnet_cidrs[1]
    error_message = "Private Subnet 2 CIDR block mismatch after creation"
  }
}
