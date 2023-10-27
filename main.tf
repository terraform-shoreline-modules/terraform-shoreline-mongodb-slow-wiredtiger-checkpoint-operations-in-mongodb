terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "slow_wiredtiger_checkpoint_operations_in_mongodb" {
  source    = "./modules/slow_wiredtiger_checkpoint_operations_in_mongodb"

  providers = {
    shoreline = shoreline
  }
}