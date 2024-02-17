data "aws_availability_zones" "available" {}
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}

locals {
  service_name   = "ecsdemo"
  container_name = "ecsdemo"
  stage          = "prod"

  vpc_cidr    = "10.0.0.0/16"
  domain_name = "mostlyfine.tech"

  keep_last_images = 30
  container_port   = 3000

}
