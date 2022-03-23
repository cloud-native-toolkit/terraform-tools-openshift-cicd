module "openshift_cicd" {
  source = "./module"

  cluster_type        = module.dev_cluster.platform.type_code
  ingress_subdomain   = module.dev_cluster.platform.ingress
  cluster_config_file = module.dev_cluster.config_file_path
  olm_namespace       = module.dev_capture_olm_state.namespace
  operator_namespace  = module.dev_capture_operator_state.namespace
  tools_namespace     = module.dev_capture_tools_state.namespace
  sealed_secret_cert  = module.cert.cert
  sealed_secret_private_key = module.cert.private_key
}

resource local_file outputs {
  filename = "${path.cwd}/.outputs"

  content = jsonencode({
    argocd_namespace = module.openshift_cicd.argocd_namespace
    sealed_secrets_namespace = module.openshift_cicd.sealed_secrets_namespace
  })
}
