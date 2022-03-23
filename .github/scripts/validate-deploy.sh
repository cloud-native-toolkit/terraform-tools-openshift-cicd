#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

ARGOCD_NAMESPACE=$(jq '.argocd_namespace' .outputs)
KUBESEAL_NAMESPACE=$(jq '.sealed_secrets_namespace' .outputs)

if [[ -f .kubeconfig ]]; then
  KUBECONFIG=$(cat .kubeconfig)
else
  KUBECONFIG="${PWD}/.kube/config"
fi
export KUBECONFIG

if ! kubectl get namespace "${ARGOCD_NAMESPACE}" 1> /dev/null 2> /dev/null; then
  echo "Naemspace not found: ${ARGOCD_NAMESPACE}"
  exit 1
fi

if ! kubectl get namespace "${KUBESEAL_NAMESPACE}" 1> /dev/null 2> /dev/null; then
  echo "Naemspace not found: ${KUBESEAL_NAMESPACE}"
  exit 1
fi

if [[ $(kubectl get argocd -n "${ARGOCD_NAMESPACE}" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | wc -l) -lt 1)
  echo "ArgoCD instance not found"
  exit 1
fi

kubectl get all -n "${KUBESEAL_NAMESPACE}"