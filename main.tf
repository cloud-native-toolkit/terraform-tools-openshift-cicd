locals {
  namespaces = [
    var.tools_namespace,
    var.sealed_secret_namespace
  ]
}


module "gitops" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd.git?ref=v2.18.3"

  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  app_namespace       = var.gitops_namespace
}

module "setup_clis" {
  source = "cloud-native-toolkit/clis/util"

  clis = ["jq", "kubectl", "oc"]
}

resource null_resource namespaces {
  triggers = {
    namespaces = jsonencode(local.namespaces)
    bin_dir = module.setup_clis.bin_dir
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/create-namespaces.sh '${self.triggers.namespaces}'"

    environment = {
      BIN_DIR = self.triggers.bin_dir
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/delete-namespaces.sh '${self.triggers.namespaces}'"

    environment = {
      BIN_DIR = self.triggers.bin_dir
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
}

module "pipelines" {
  source = "github.com/cloud-native-toolkit/terraform-tools-tekton.git?ref=v2.4.0"
  depends_on = [null_resource.namespaces]

  cluster_config_file_path = var.cluster_config_file
  cluster_ingress_hostname = var.ingress_subdomain
  tools_namespace          = var.tools_namespace
  provision                = module.gitops.provision_tekton
}

module "sealed_secrets" {
  source = "github.com/cloud-native-toolkit/terraform-tools-sealed-secrets.git?ref=v1.1.5"
  depends_on = [null_resource.namespaces]

  cluster_config_file = var.cluster_config_file
  private_key = var.sealed_secret_private_key
  cert = var.sealed_secret_cert
  namespace = var.sealed_secret_namespace
}
