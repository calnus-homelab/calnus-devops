
locals {
  proxy_ip = "192.168.1.6"

  dns_names = [
    "harvester",
    "rancher",
    "truenas",
    "grafana",
    "home-assistant",
    "immich",
    "jellyfin",
    "pve",
    "s3",
    "s3-gui",
    "gitlab",
    "localai",
    "ytd"
  ]

  dns_records = [
    for name in local.dns_names : {
      name  = name
      type  = "A"
      value = local.proxy_ip
      ttl   = 1
    }
  ]
}



resource "cloudflare_record" "tracked" {
  for_each = { for rec in local.dns_records : rec.name => rec }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = each.value.ttl

  lifecycle {
    prevent_destroy = true
  }
}
