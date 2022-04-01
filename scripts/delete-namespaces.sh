#!/usr/bin/env bash

NAMESPACES_JSON="$1"

export PATH="${BIN_DIR}:${PATH}"

echo "${NAMESPACES_JSON}" | jq -r '.[]' | while read namespace; do
  if [[ $(kubectl get namespace -l created-by=openshift-cicd | grep -qc ${namespace}) -gt 0 ]]; then
    echo "Deleting namespace: ${namespace}"

    if oc get project "${namespace}" 1> /dev/null 2> /dev/null; then
      oc delete project "${namespace}" 1> /dev/null 2> /dev/null
    else
      kubectl delete namespace "${namespace}" 1> /dev/null 2> /dev/null
    fi
  else
    echo "Namespace created by someone else: ${namespace}"
  fi
done
