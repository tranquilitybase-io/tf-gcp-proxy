// Image to be used by the Squid Proxy template
data "google_compute_image" "centos_image" {
  family  = "centos-7"
  project = "centos-cloud"
}
