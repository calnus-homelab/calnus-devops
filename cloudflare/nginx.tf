locals {
  domain = "lanfordlabs.com"
  default_scheme = "http"
  certificate_id = 7
  apps = [
    { name = "gitlab",          ip = "192.168.1.6",   port = 10080, scheme = "http" },
    { name = "s3-gui",          ip = "192.168.1.16",  port = 9002 },
    { name = "s3",              ip = "192.168.2.16",  port = 9000 },
    { name = "grafana",         ip = "192.168.1.7",   port = 3030 },
    { name = "home-assistant",  ip = "192.168.1.3",   port = 8123 },
    { name = "pve",             ip = "192.168.1.24",  port = 8006, scheme = "https" },
    { name = "pve-dev",         ip = "192.168.2.2",   port = 8006, scheme = "https" },
    { name = "harvester",       ip = "192.168.2.27",  port = 443,  scheme = "https" },
    { name = "rancher",         ip = "192.168.2.27",  port = 443,  scheme = "https" },
    { name = "truenas",         ip = "192.168.1.16",  port = 443,  scheme = "https" },
    { name = "immich",          ip = "192.168.1.8",   port = 2283 },
    { name = "jellyfin",        ip = "192.168.1.59",  port = 8096 },
    { name = "localai",         ip = "192.168.1.227", port = 8080 },
    { name = "meshcommander",   ip = "192.168.1.9", port = 3000 },
    { name = "ytd",             ip = "192.168.1.8",   port = 8000 }
  ]
  proxy_hosts = [
    for app in local.apps : {
      name           = app.name
      ip             = app.ip
      forward_scheme = lookup(app, "scheme", local.default_scheme)
      subdomain      = app.name
      forward_port   = app.port
    }
  ]

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

