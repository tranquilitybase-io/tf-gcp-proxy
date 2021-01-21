// Creates Ingress firewall rule for the squid proxy Service Account
resource "google_compute_firewall" "allow_proxy_http_ingress" {
  name    = var.firewall_rule_name
  network = var.shared_vpc_name
  project = var.shared_networking_id

  allow {
    protocol = "tcp"
    ports    = [80, 443, 8008, 8080, 8443]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  source_service_accounts = [
    var.proxy_sa_email
  ]
}