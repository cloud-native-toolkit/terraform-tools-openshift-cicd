
output "argocd_namespace" {
  description = "The namespace where the ArgoCD instance has been provisioned"
  value       = module.argocd.namespace
}
