locals {
  domain = "lanfordlabs.com"
  proxy_hosts = [
    { name = "gitlab",          ip = "192.168.1.6", forward_scheme = "http", subdomain = "gitlab", forward_port = 10080 },
    { name = "s3-gui",          ip = "192.168.1.16", forward_scheme = "http", subdomain = "s3-gui", forward_port = 9002 },
    { name = "s3",              ip = "192.168.1.16", forward_scheme = "http", subdomain = "s3", forward_port = 9000 },
    { name = "grafana",         ip = "192.168.1.7", forward_scheme = "http", subdomain = "grafana", forward_port = 3030 },
    { name = "home-assistant",  ip = "192.168.1.3", forward_scheme = "http", subdomain = "home-assistant", forward_port = 8123 },
    { name = "pve",             ip = "192.168.1.24", forward_scheme = "https", subdomain = "pve", forward_port = 8006 },
    { name = "harvester",       ip = "192.168.2.27", forward_scheme = "https", subdomain = "harvester", forward_port = 443 },
    { name = "rancher",         ip = "192.168.2.27", forward_scheme = "https", subdomain = "rancher", forward_port = 443 },
    { name = "truenas",         ip = "192.168.1.16", forward_scheme = "https", subdomain = "truenas", forward_port = 443 },
    { name = "immich",          ip = "192.168.1.8", forward_scheme = "http", subdomain = "immich", forward_port = 2283 },
    { name = "jellyfin",        ip = "192.168.1.59", forward_scheme = "http", subdomain = "jellyfin", forward_port = 8096 }
  ]
  certificate_id = 7
}
resource "nginxproxymanager_proxy_host" "tracked" {
  for_each       = { for ph in local.proxy_hosts : ph.name => ph }
  domain_names   = ["${each.value.subdomain}.${local.domain}"]
  forward_scheme = each.value.forward_scheme
  forward_host   = each.value.ip
  forward_port   = each.value.forward_port
  access_list_id = 0 # Publicly Accessible
  certificate_id = local.certificate_id
  ssl_forced     = true
}
