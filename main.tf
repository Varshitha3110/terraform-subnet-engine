module "vpc" {

  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
}

module "subnet_engine" {

  source = "./modules/subnet_engine"

  vpc_id = module.vpc.vpc_id

  vpc_cidr = var.vpc_cidr

  tiers = var.tiers
}

module "networking" {

  source = "./modules/networking"

  vpc_id = module.vpc.vpc_id

  public_subnets = module.subnet_engine.public_subnets
}

module "security_groups" {

  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id

  tiers = var.tiers
}