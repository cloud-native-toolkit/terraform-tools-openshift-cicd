
module "gitops" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd.git?ref=v2.18.0"

  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  app_namespace       = var.gitops_namespace
}

module "pipelines" {
  source = "github.com/cloud-native-toolkit/terraform-tools-tekton.git?ref=v2.4.0"

  cluster_config_file_path = var.cluster_config_file
  cluster_ingress_hostname = var.ingress_subdomain
  tools_namespace          = var.tools_namespace
  provision                = module.gitops.provision_tekton
}

module "sealed_secrets" {
  source = "github.com/cloud-native-toolkit/terraform-tools-sealed-secrets.git?ref=v1.1.4"

  cluster_config_file = var.cluster_config_file
  private_key = var.sealed_secret_private_key
  cert = var.sealed_secret_cert
  namespace = var.sealed_secret_namespace
}
