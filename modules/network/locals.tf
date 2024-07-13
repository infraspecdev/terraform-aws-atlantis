locals {
  vpc_name                   = "atlantis-ecs-vpc"
  public_1_subnet_name       = "atlantis-ecs-vpc-public-subnet-1"
  private_1_subnet_name      = "atlantis-ecs-vpc-private-subnet-1"
  private_1_route_table_name = "atlantis-ecs-vpc-private-route-table-1"
  public_1_route_table_name  = "atlantis-ecs-vpc-public-route-table-1"
  public_2_subnet_name       = "atlantis-ecs-vpc-public-subnet-2"
  private_2_subnet_name      = "atlantis-ecs-vpc-private-subnet-2"
  private_2_route_table_name = "atlantis-ecs-vpc-private-route-table-2"
  public_2_route_table_name  = "atlantis-ecs-vpc-public-route-table-2"
  igw_name                   = "atlantis-ecs-vpc-internet-gateway"
}
