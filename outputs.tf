
output "operator_namespace" {
  description = "The namespace where the operators were deployed"
  value       = module.pipelines.operator_namespace
}

output "operator_names" {
  description = "The namespace where the operators were deployed"
  value       = [
    module.gitops.operator_name,
    module.pipelines.operator_name
  ]
}

output "argocd_namespace" {
  description = "The namespace where the ArgoCD instance has been provisioned"
  value       = module.gitops.namespace
}

output "argocd_service_account" {
  description = "The namespace where the ArgoCD instance has been provisioned"
  value       = module.gitops.service_account
}

output "argocd_host" {
  description = "The ingress host for the Argo CD instance"
  value = module.gitops.ingress_host
  sensitive = true
}

output "argocd_url" {
  description = "The ingress url for the Argo CD instance"
  value = module.gitops.ingress_url
  sensitive = true
}

output "argocd_username" {
  description = "The username of the default ArgoCD admin user"
  value = module.gitops.username
}

output "argocd_password" {
  description = "The password of the default ArgoCD admin user"
  value = module.gitops.password
  sensitive = true
}

output "sealed_secrets_private_key" {
  value = module.sealed_secrets.private_key
  sensitive = true
}

output "sealed_secrets_cert" {
  value = module.sealed_secrets.cert
}

output "sealed_secrets_namespace" {
  value = module.sealed_secrets.namespace
}

output "tekton_namespace" {
  value = module.pipelines.namespace
}
