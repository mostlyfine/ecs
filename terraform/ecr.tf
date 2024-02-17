data "aws_caller_identity" "current" {}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name                   = "${local.service_name}-ecr"
  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  repository_image_scan_on_push     = true
  repository_encryption_type        = "AES256"
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "keep last ${local.keep_last_images} images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan",
          countNumber   = local.keep_last_images
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true
}
