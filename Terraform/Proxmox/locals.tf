
locals {
  defaults = {
    instance_type  = "t3.small"
    ssh_public_key = "id_ed25519.pub"
  }
  merged_nodes = {
    for name, cfg in local.nodes :
    name => merge(local.defaults, cfg)
  }
}