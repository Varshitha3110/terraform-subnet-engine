output "vpc_id" {

  value = module.vpc.vpc_id
}

output "generated_subnets" {

  value = module.subnet_engine.generated_subnets
}

output "public_subnets" {

  value = module.subnet_engine.public_subnets
}

output "private_subnets" {

  value = module.subnet_engine.private_subnets
}

output "security_groups" {

  value = module.security_groups.security_group_ids
}
