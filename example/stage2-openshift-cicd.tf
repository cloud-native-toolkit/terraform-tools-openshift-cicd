module "openshift_cicd" {
  source = "../"

  cluster_type        = module.cluster.platform.type_code
  ingress_subdomain   = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  olm_namespace       = module.olm.olm_namespace
  operator_namespace  = module.olm.target_namespace
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
