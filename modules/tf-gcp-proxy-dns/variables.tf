variable "squid_proxy_instances" {
  type    = list(string)
  description = "List on Squid Proxy instances"
}

variable "zone" {}

variable "shared_networking" {}

variable "private_dns_domain_name" {}

variable "private_dns_name" {}