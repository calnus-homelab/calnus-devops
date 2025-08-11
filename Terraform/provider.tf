terraform {
  required_version = ">= 0.13"
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "0.6.7"
    }
  }
}

provider "harvester" {
  # Path to kubeconfig file 
  kubeconfig  = pathexpand("~/.kube/config")
  kubecontext = "local"

}
