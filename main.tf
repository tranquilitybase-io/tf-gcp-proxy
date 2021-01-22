module "firewall_rules" {
  source = "./modules/tf-gcp-firewall-rules"
  proxy_sa_email = module.service_account.proxy_sa_email
  shared_networking_id = var.shared_networking_id
  firewall_rule_name = var.firewall_rule_name
  shared_vpc_name = var.shared_vpc_name
  depends_on = [module.service_account]
}

module "proxy_instance" {
  source = "./modules/tf-gcp-proxy-instance"
  bastion_subnetwork_name = var.bastion_subnetwork_name
  proxy_sa_email = module.service_account.proxy_sa_email
  region = var.region
  region_zone = var.region_zone
  shared_bastion_id = var.shared_bastion_id
  shared_networking_id = var.shared_networking_id
  template_name = var.template_name
  scopes = var.scopes
  group_name = var.group_name
  instance_name = var.instance_name
  depends_on = [module.service_account]
}

module "service_account" {
  source = "./modules/tf-gcp-service-account"
  root_id = var.root_id
  shared_bastion_id = var.shared_bastion_id
  main_iam_service_account_roles = var.main_iam_service_account_roles
  sa_name = var.sa_name
}

module "proxy_dns" {
  source = "./modules/tf-gcp-proxy-dns"
  private_dns_domain_name = var.private_dns_domain_name
  private_dns_name = var.private_dns_name
  shared_networking = var.shared_networking_id
  squid_proxy_instances = module.proxy_instance.squid_proxy_instances
  zone = var.region_zone
  depends_on = [module.proxy_instance]
}
