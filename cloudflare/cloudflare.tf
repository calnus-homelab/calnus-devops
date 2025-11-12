locals {
  proxy_ip = "192.168.1.6"

  dns_names = [
    { name = "harvester", ip="192.168.2.27"},
    { name = "rancher", ip="192.168.2.27" },
    { name = "truenas" },
    { name = "grafana" },
    { name = "home-assistant" },    
    { name = "pve" },
    { name = "pve-dev" },
    { name = "s3" },
    { name = "s3-gui" },
    { name = "gitlab" },
    { name = "localai" },
    { name = "ytd" },
    { name = "isos", ip="192.168.68.4" },
    { name = "seafile"},
    { name = "nas", ip="192.168.68.4" },
    { name = "minio", ip="192.168.68.4" },
    { name = "minio-gui", ip="192.168.68.4" },
    { name = "pve-local", ip="192.168.68.4" },
    { name = "harbor", ip="192.168.68.4" },
    { name = "biblioteca", ip="192.168.68.4" },
    { name = "meshcommander" }
   ]

  dns_records = [
    for domain in local.dns_names : {
      name  = domain.name
      type  = "A"
      value = local.proxy_ip
      value = lookup(domain, "ip", local.proxy_ip)
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

}
