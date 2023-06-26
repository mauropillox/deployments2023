# # Crea el grupo de parámetros para Redis
# resource "aws_elasticache_parameter_group" "redis_parameter_group1" {
#   name   = "obligatorio-redis-parameter-group"
#   family = "redis6.x"

#   parameter {
#     name  = "cluster-enabled"
#     value = "no"
#   }
# }

# # Crea una instancia de Redis
# resource "aws_elasticache_subnet_group" "redis_subnet_group" {
#   name = "obligatorio-redis-subnet-group"
#   subnet_ids = [
#     aws_subnet.obligatorio_private_subnet.id,
#     aws_subnet.obligatorio_private_subnet_2.id
#   ]
# }

# resource "aws_elasticache_cluster" "redis_instance" {
#   cluster_id           = "obligatorio-redis-instance"
#   engine               = "redis"
#   engine_version       = "6.x"
#   node_type            = "cache.t2.micro"
#   num_cache_nodes      = 1
#   port                 = 6379
#   subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
#   parameter_group_name = aws_elasticache_parameter_group.redis_parameter_group1.name
#   security_group_ids   = [aws_security_group.redis_sg.id]
# }
