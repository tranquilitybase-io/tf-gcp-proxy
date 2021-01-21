// Create instance template for the squid proxy
resource "google_compute_instance_template" "squid_proxy_template" {
  project = var.shared_bastion_id
  name    = var.template_name

  machine_type = "n1-standard-2"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // boot disk
  disk {
    source_image = data.google_compute_image.centos_image.self_link
  }

  network_interface {
    subnetwork = "projects/${var.shared_networking_id}/regions/${var.region}/subnetworks/${var.bastion_subnetwork_name}"
  }

  service_account {
    email  = var.proxy_sa_email
    scopes = var.scopes
  }

  metadata_startup_script = file("${path.module}/squid_startup.sh")

}

// Create instance group for the squid proxy
resource "google_compute_instance_group_manager" "squid_proxy_group" {
  project            = var.shared_bastion_id
  base_instance_name = var.instance_name
  zone               = var.region_zone

  version {
    instance_template = google_compute_instance_template.squid_proxy_template.self_link
    name              = var.template_name
  }

  target_size = 1
  name        = var.group_name

}

resource "time_sleep" "squid_wait_30_seconds" {
  depends_on = [google_compute_instance_group_manager.squid_proxy_group]

  create_duration = "80s"
}

resource "null_resource" "start-iap-tunnel" {

  provisioner "local-exec" {
    command = <<EOF
echo '
INSTANCE=$(gcloud compute instance-groups managed list-instances ${var.group_name} --project=${var.shared_bastion_id} --zone ${var.region_zone} --format="value(instance.scope(instances))")
gcloud compute start-iap-tunnel $INSTANCE 3128 --local-host-port localhost:3128 --project ${var.shared_bastion_id} --zone ${var.region_zone} > /dev/null 2>&1 &
TUNNELPID=$!
sleep 10
export HTTPS_PROXY="localhost:3128"' | tee -a /opt/tb/repo/tb-gcp-tr/landingZone/iap-tunnel.sh
EOF
  }
  depends_on = [google_compute_instance_group_manager.squid_proxy_group]
}