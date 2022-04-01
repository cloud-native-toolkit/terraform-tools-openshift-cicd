#!/usr/bin/env bash

NAMESPACES="$1"

export PATH"${BIN_DIR}:${PATH}"

echo "${NAMESPACES}" | jq -r '.[]' | while read namespace; do
  if ! kubectl get namespace "${namespace}" 1> /dev/null 2> /dev/null; then
    echo "Creating namespace: ${namespace}"

    if kubectl get routes -A 1> /dev/null 2> /dev/null; then
      oc new-project "${namespace}" 1> /dev/null || exit 1
    else
      kubectl create namespace "${namespace}" 1> /dev/null || exit 1
    fi

    oc label namespace "${namespace}" created-by=openshift-cicd
  else
    echo "Namespace already exists: ${namespace}"
  fi
done
