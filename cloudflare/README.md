# Terraform Provider Configuration: Cloudflare & Nginx Proxy Manager

This project contains a basic **Terraform** configuration using the **Cloudflare** and **Nginx Proxy Manager** providers. It allows you to manage Cloudflare resources and configure proxy hosts automatically through Nginx Proxy Manager.

---

## Requirements

- [Terraform](https://www.terraform.io/downloads) >= 1.5.0  
- Active **Cloudflare** account with API Key  
- Accessible **Nginx Proxy Manager** installation  
- Environment variables set for authentication  

---

## Providers

| Provider | Source | Version |
|----------|--------|---------|
| Cloudflare | `cloudflare/cloudflare` | `~> 4` |
| Nginx Proxy Manager | `Sander0542/nginxproxymanager` | `0.0.33` |

---

## Configuration

1. **Install Terraform**  
   Make sure Terraform is installed on your system.

2. **Set environment variables**  

   Before running Terraform, export the following variables:

   ```bash
   export CLOUDFLARE_API_KEY="your_api_key_here"
   export NGINX_PROXY_MANAGER_URL="http://your_nginx_proxy_manager"
   export NGINX_PROXY_MANAGER_USERNAME="username"
   export NGINX_PROXY_MANAGER_PASSWORD="password"
   ```

   > These variables allow the provider to authenticate with Cloudflare and Nginx Proxy Manager.

3. **Initialize Terraform**  

   ```bash
   terraform init
   ```

4. **Plan changes**  

   ```bash
   terraform plan
   ```

5. **Apply the configuration**  

   ```bash
   terraform apply
   ```

---

## Usage Example

Here’s an example of adding a new Domain name in Cloudflare:
local.proxy_ip always point to the same Proxy IP address
```hcl
    dns_records = [
        {         
            name = "gitlab",          
            type = "A", 
            value = local.proxy_ip, 
            ttl = 1                 
        }, ...    
    ]
```
Here’s an example of adding a new proxy host in Nginx Proxy Manager:

```hcl
proxy_hosts = [
   { 
        name = "gitlab", 
        ip = "192.168.1.6", #IP address where the services is actually running
        forward_scheme = "http", 
        subdomain = "gitlab", 
        forward_port = 10080 
    }, ...
  ]
```

---

## Notes

- Ensure the Cloudflare API Key has sufficient permissions to manage zones and DNS records.  
- The Nginx Proxy Manager URL must be reachable from where Terraform is executed.  
- Provider versions can be updated according to project requirements.

