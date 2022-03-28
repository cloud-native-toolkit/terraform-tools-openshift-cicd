#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

ARGOCD_NAMESPACE=$(jq -r '.argocd_namespace' .outputs)
KUBESEAL_NAMESPACE=$(jq -r '.sealed_secrets_namespace' .outputs)

if [[ -f .kubeconfig ]]; then
  KUBECONFIG=$(cat .kubeconfig)
else
  KUBECONFIG="${PWD}/.kube/config"
fi
export KUBECONFIG

if ! kubectl get namespace "${ARGOCD_NAMESPACE}" 1> /dev/null 2> /dev/null; then
  echo "Namespace not found: ${ARGOCD_NAMESPACE}"
  kubectl get namespace
  echo "Grepping for namespace"
  kubectl get namespace | grep "${ARGOCD_NAMESPACE}"
  exit 1
fi

if ! kubectl get namespace "${KUBESEAL_NAMESPACE}" 1> /dev/null 2> /dev/null; then
  echo "Namespace not found: ${KUBESEAL_NAMESPACE}"
  exit 1
fi

if [[ $(kubectl get argocd -n "${ARGOCD_NAMESPACE}" -o json | jq '.items | length') -lt 1 ]]; then
  echo "ArgoCD instance not found"
  exit 1
fi

kubectl get all -n "${KUBESEAL_NAMESPACE}"
