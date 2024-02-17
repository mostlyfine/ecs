module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = local.service_name
  cidr = local.vpc_cidr

  azs            = data.aws_availability_zones.available.names
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

