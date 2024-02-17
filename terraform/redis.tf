#
# example
#

# create_elasticache_subnet_group するのに必要
# module "this" {
#   source  = "cloudposse/label/null"
#   version = "0.25.0"

#   name  = local.service_name
#   stage = local.stage
# }

# module "redis" {
#   source = "cloudposse/elasticache-redis/aws"

#   version = "1.2.0"

#   replication_group_id = local.container_name
#   description          = "Managed by Terraform"
#   vpc_id               = module.vpc.vpc_id
#   availability_zones   = data.aws_availability_zones.available.names
#   subnets              = data.aws_subnets.all.ids

#   cluster_size                 = 2
#   cluster_mode_num_node_groups = 1

#   family         = "redis7" # "redis6.x" # redis7
#   engine_version = "7.1"    # "6.x"      # 7.1
#   instance_type  = "cache.t4g.small"

#   create_parameter_group = false
#   parameter_group_name          = aws_elasticache_parameter_group.redis7.name # "default.redis7" or "default.redis6.x"
#   create_security_group         = false
#   associated_security_group_ids = [module.elasticache_sg.security_group_id]
#   elasticache_subnet_group_name = aws_elasticache_subnet_group.redis7.name

#   auto_minor_version_upgrade = true
#   automatic_failover_enabled = true
#   at_rest_encryption_enabled = false
#   transit_encryption_enabled = false
#   multi_az_enabled           = true

#   snapshot_retention_limit = 30
#   snapshot_window          = "00:00-01:00"
#   maintenance_window       = "mon:17:00-mon:18:00"

#   log_delivery_configuration = [
#     {
#       destination      = aws_cloudwatch_log_group.redis.name
#       destination_type = "cloudwatch-logs"
#       log_format       = "json"
#       log_type         = "slow-log"
#     }
#   ]
#   # context = module.this.context
# }

# resource "aws_elasticache_parameter_group" "redis7" {
#   name        = "${local.service_name}-redis7"
#   family      = "redis7"
#   description = "Managed by Terraform"

#   parameter {
#     name  = "slowlog-log-slower-than"
#     value = "100000" # 0.1sec
#   }
# }

# resource "aws_elasticache_subnet_group" "redis7" {
#   name       = "redis7"
#   subnet_ids = data.aws_subnets.all.ids
# }

# resource "aws_cloudwatch_log_group" "redis" {
#   name              = "/aws/elasticache/redis/slowlog"
#   retention_in_days = 7
# }

# module "elasticache_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.1.0"

#   name                = "${local.container_name}-elasticache"
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = [local.vpc_cidr]
#   ingress_rules       = ["redis-tcp"]
#   egress_rules        = ["all-all"]
# }
