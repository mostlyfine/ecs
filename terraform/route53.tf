module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.11.0"

  zones = {
    "${local.domain_name}" = {
      comment = "Managed by Terraform"
    }
  }
}
