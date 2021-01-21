variable "shared_bastion_id" {
  type        = string
  description = "TB Bastion ID"
}

variable "template_name" {
  type        = string
  description = "Proxy Instance Template"
}

variable "instance_name" {
  type        = string
  description = "Base Instance Name"
}

variable "group_name" {
  type        = string
  description = "Instance Group Manager Name"
}

variable "proxy_sa_email" {
  type        = string
  description = "Email for the proxy SA"
}

variable "scopes" {
  type        = list(string)
  description = "A list of service scopes attached to the bootstrap terraform server. To allow full access to all Cloud APIs, use the cloud-platform scope. For other scopes see here: https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes "
}

variable "shared_networking_id" {
  type        = string
  description = "identifier for the shared_networking project."
}

variable "region" {
  type        = string
  description = "region name."
}

variable "bastion_subnetwork_name" {
  description = "Subnetwork where bastion and proxy servers should be deployed at."
  type        = string
}

variable "region_zone" {
  type        = string
  description = "zone name in the region provided."
}