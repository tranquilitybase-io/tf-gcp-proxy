// Gets the squid proxy instance group from the squid proxy instance group manager
data "google_compute_instance_group" "squid_proxy_instance_group" {
  depends_on = [time_sleep.squid_wait_30_seconds]
  self_link = google_compute_instance_group_manager.squid_proxy_group.instance_group
}