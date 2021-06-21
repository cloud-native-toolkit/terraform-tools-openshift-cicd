
output "argocd_namespace" {
  description = "The namespace where the ArgoCD instance has been provisioned"
  value       = module.gitops.namespace
}

output "argocd_host" {
  description = "The ingress host for the Argo CD instance"
  value = module.gitops.ingress_host
}

output "argocd_url" {
  description = "The ingress url for the Argo CD instance"
  value = module.gitops.ingress_url
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
