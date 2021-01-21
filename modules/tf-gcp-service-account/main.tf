resource "google_service_account" "proxy-sa-res" {
  account_id   = var.sa_name
  display_name = var.sa_name
  project      = var.shared_bastion_id
}

locals {
  service_account_name = "serviceAccount:${google_service_account.proxy-sa-res.account_id}@${var.shared_bastion_id}.iam.gserviceaccount.com"
}

resource "google_folder_iam_member" "sa-folder-admin-role" {
  count      = length(var.main_iam_service_account_roles)
  folder     = "folders/${var.root_id}"
  role       = element(var.main_iam_service_account_roles, count.index)
  member     = local.service_account_name
  depends_on = [google_service_account.proxy-sa-res]
}