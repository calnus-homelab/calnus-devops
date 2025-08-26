resource "harvester_storageclass" "local-storage-replicas-1" {
  name = "local-storage-replicas-1"
  is_default        = "true"
  parameters = {
    "migratable"          = "true"
    "numberOfReplicas"    = "1"
    "staleReplicaTimeout" = "30"
    "defaultClass"        = "true"
    
  }
}
