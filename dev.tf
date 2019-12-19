module "poc-network" {
  source     = "terraform/eu-central-1/modules/vpc"
  ENV        = "dev"
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "terraform/eu-central-1/modules/instances"
  ENV            = "dev"
  AWS_REGION	 = var.AWS_REGION
  VPC_ID         = module.poc-network.vpc_id
  PUBLIC_SUBNETS = module.poc-network.public_subnets
  PRIVATE_SUBNETS = module.poc-network.private_subnets
}