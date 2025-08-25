
locals {
  proxy_ip    = "192.168.1.6"
  proxy_lb_Ip = "192.168.1.6"

  dns_names = [
    { name = "harvester",         adress = proxy_ip },
    { name = "rancher",           adress = proxy_ip },
    { name = "truenas",           adress = proxy_ip },
    { name = "grafana",           adress = proxy_ip },
    { name = "home-assistant",    adress = proxy_ip },
    { name = "immich",            adress = proxy_ip },
    { name = "jellyfin",          adress = proxy_ip },
    { name = "pve",               adress = proxy_ip },
    { name = "pve.dev",           adress = proxy_ip },
    { name = "s3",                adress = proxy_ip },
    { name = "s3-gui",            adress = proxy_lb_Ip },
    { name = "gitlab",            adress = proxy_lb_Ip },
    { name = "localai",           adress = proxy_lb_Ip },
    { name = "ytd",               adress = proxy_lb_Ip }
  ]

  dns_records = [
    for domain in local.dns_names : {
      name  = app.name
      type  = "A"
      value = app.adress
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
