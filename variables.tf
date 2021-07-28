variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "cluster_type" {
  type        = string
  description = "The type of cluster (openshift or kubernetes)"
}

variable "olm_namespace" {
  type        = string
  description = "Namespace where olm is installed"
}

variable "operator_namespace" {
  type        = string
  description = "Namespace where operators will be installed"
}

variable "app_namespace" {
  type        = string
  description = "Namespace where operators will be installed"
}

variable "ingress_subdomain" {
  type        = string
  description = "The subdomain for ingresses in the cluster"
  default     = ""
}

variable "sealed_secret_public_key" {
  type        = string
  description = "The public key that will be used to encrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "sealed_secret_private_key" {
  type        = string
  description = "The private key that will be used to decrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "sealed_secret_public_key_file" {
  type        = string
  description = "The file containing the public key that will be used to encrypt the sealed secrets. If not provided a new public key will be generated"
  default     = ""
}

variable "sealed_secret_private_key_file" {
  type        = string
  description = "The file containin the private key that will be used to encrypt the sealed secrets. If not provided a new private key will be generated"
  default     = ""
}

variable "sealed_secret_namespace" {
  type        = string
  description = "The namespace where the sealed secret will be deployed"
  default     = "sealed-secrets"
}