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

variable "gitops_namespace" {
  type        = string
  description = "Namespace where OpenShift GitOps will be installed"
  default     = ""
}

variable "ingress_subdomain" {
  type        = string
  description = "The subdomain for ingresses in the cluster"
  default     = ""
}

variable "tls_secret_name" {
  type        = string
  description = "The name of the secret that contains the ingress tls info"
  default     = ""
}

variable "sealed_secret_cert" {
  type        = string
  description = "The certificate that will be used to encrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "sealed_secret_private_key" {
  type        = string
  description = "The private key that will be used to decrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "sealed_secret_namespace" {
  type        = string
  description = "The namespace where the sealed secret will be deployed"
  default     = "sealed-secrets"
}
