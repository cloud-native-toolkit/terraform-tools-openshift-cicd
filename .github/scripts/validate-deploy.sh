#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

ARGOCD_NAMESPACE=$(jq -r '.argocd_namespace' .outputs)
KUBESEAL_NAMESPACE=$(jq -r '.sealed_secrets_namespace' .outputs)
OPERATOR_NAMESPACE=$(jq -r '.operator_namespace' .outputs)
OPERATOR_NAMES=$(jq -c '.operator_names' .outputs)

if [[ -f .kubeconfig ]]; then
  KUBECONFIG=$(cat .kubeconfig)
else
  KUBECONFIG="${PWD}/.kube/config"
fi
export KUBECONFIG

source "${SCRIPT_DIR}/validation-functions.sh"

if ! kubectl get namespace "${ARGOCD_NAMESPACE}" 1> /dev/null 2> /dev/null; then
  echo "Namespace not found: ${ARGOCD_NAMESPACE}"
  kubectl get namespace
  echo "Grepping for namespace"
  kubectl get namespace | grep "${ARGOCD_NAMESPACE}"
  exit 1
fi

check_k8s_namespace "${ARGOCD_NAMESPACE}"
check_k8s_namespace "${KUBESEAL_NAMESPACE}"
check_k8s_namespace "${OPERATOR_NAMESPACE}"

echo "${OPERATOR_NAMES}" | jq -r '.[]' | while read name; do
  check_k8s_resource "${OPERATOR_NAMESPACE}" subscription "${name}"
done
