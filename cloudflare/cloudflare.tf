
locals {
  proxy_ip = "192.168.1.6"

  dns_records = [
    { name = "harvester",       type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "rancher",         type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "truenas",         type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "grafana",         type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "home-assistant",  type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "immich",          type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "jellyfin",        type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "pve",             type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "s3",              type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "s3-gui",          type = "A", value = local.proxy_ip, ttl = 1 },
    { name = "gitlab",          type = "A", value = local.proxy_ip, ttl = 1 }
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
