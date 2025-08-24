terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
    nginxproxymanager = {
      source = "Sander0542/nginxproxymanager"
      version = "0.0.33"
    }
  }
}

provider "cloudflare" {}
provider "nginxproxymanager" {}