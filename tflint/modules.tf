module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demoapp-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  identifier = "demoapp-primary"
  engine     = "postgres"
}

module "shared_helpers" {
  source = "git::https://github.com/demoapp/terraform-shared-helpers.git"
}

module "internal_observability" {
  source = "git::ssh://git@github.com/demoapp/terraform-observability.git//modules/datadog"
}

module "legacy_networking" {
  source = "../../shared-modules/networking"
}
