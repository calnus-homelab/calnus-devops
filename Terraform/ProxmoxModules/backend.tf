terraform {
    backend "s3" {
        bucket = "terraform"                  # Name of the S3 bucket
        endpoints = {
            s3 = "https://s3.lanfordlabs.com"   # Minio endpoint
        }
        key = "proxmox-modules/terraform.tfstate"        # Name of the tfstate file
        region = "local"                     # Region validation will be skipped
        skip_region_validation = true
        skip_credentials_validation = true  # Skip AWS related checks and validations
        skip_requesting_account_id = true
        skip_metadata_api_check = true        
        use_path_style = true             # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
    }
}
