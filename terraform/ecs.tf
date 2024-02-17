# module "ecs" {
#   source  = "terraform-aws-modules/ecs/aws"
#   version = "5.8.0"
# 
#   cluster_name = "${local.service_name}-cluster"
# 
#   cluster_settings = {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# 
#   fargate_capacity_providers = {
#     FARGATE_SPOT = {
#       default_capacity_provider_strategy = {
#         weight = 100
#       }
#     }
#   }
#   services = {
#     (local.container_name) = {
#       cpu    = 256
#       memory = 512
# 
#       container_definitions = {
#         app = {
#           essential = true
#           image     = "public.ecr.aws/nginx/nginx:latest"
#           port_mappings = [
#             {
#               containerPort = 80
#               hostPort      = 80
#               protocol      = "TCP"
#             }
#           ]
#           dependencies = [{
#             containerName = "fluentbit"
#             condition     = "START"
#           }]
#           enable_cloudwatch_logging = true
#           log_configuration = {
#             logDriver = "awsfirelens"
#             options = {
#             }
#           }
#         }
# 
#         fluentbit = {
#           essential = true
#           image     = "906394416424.dkr.ecr.us-west-2.amazonaws.com/aws-for-fluent-bit:stable"
#           firelens_configuration = {
#             type = "fluentbit"
#           }
#         }
# 
#       }
#       subnet_ids = module.vpc.public_subnets
# 
#       load_balancer = {
#         service = {
#           target_group_arn = module.alb.target_groups["ecs-tg"].arn
#           container_name   = local.container_name
#           container_port   = local.container_port
#         }
#       }
# 
#       security_group_rules = {
#         alb_ingress_3000 = {
#           type                     = "ingress"
#           from_port                = local.container_port
#           to_port                  = local.container_port
#           protocol                 = "tcp"
#           description              = "Service port"
#           source_security_group_id = module.alb.security_group_id
#         }
#         egress_all = {
#           type        = "egress"
#           from_port   = 0
#           to_port     = 0
#           protocol    = "-1"
#           cidr_blocks = ["0.0.0.0/0"]
#         }
#       }
#     }
#   }
# }
