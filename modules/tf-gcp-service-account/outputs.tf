output proxy_sa_email {
  description = "Email Address of the Proxy Service Account"
  value = google_service_account.proxy-sa-res.email
}

