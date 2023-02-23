
terraform {
  required_version = ">= 0.12.19"

  required_providers {
    aws = {
      version = ">=3.21.0" # There was a bug fix for aws_backup_plan in 3.21.0
    }
  }
}


module "example" {
  source = "../.."

  name = "test"
}

output "example" {
  value = module.example
}
