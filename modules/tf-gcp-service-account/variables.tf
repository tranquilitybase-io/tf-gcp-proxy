variable "shared_bastion_id" {
  type        = string
  description = "TB Bastion ID"
}

variable "sa_name" {
  type        = string
  description = "Display name to be used for the Service Account"
}

variable "main_iam_service_account_roles" {
  type = list(string)
  description = "Roles attached to service account"
}

variable root_id {
  type        = string
  description = "ID for the parent organisation where folders will be created"
}
