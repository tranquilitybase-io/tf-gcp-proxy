// outputs the set of squid proxy instances from the squid proxy instance group
output squid_proxy_instances {
  description = "The set of squid proxy instances"
  value = tolist(data.google_compute_instance_group.squid_proxy_instance_group.instances)
}