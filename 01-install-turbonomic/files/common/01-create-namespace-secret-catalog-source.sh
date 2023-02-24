#!/usr/bin/env bash

function create_namespace_secret_catalog_source() {

echo "----------------------------------------------------------------------"
echo "1. Installing - Namespace, OperatorGroup, secrets, ServiceAccount and CatalogSource started"
echo "----------------------------------------------------------------------"

echo "-----------------------------------"
echo "1.1. Create namespace turbonomic ..."
echo "-----------------------------------"
oc create namespace $NAMESPACE

sleep 3
oc project turbonomic


echo "-----------------------------------"
echo "1.2. Create OperatorGroup ..."
echo "-----------------------------------"
cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  generateName: turbonomic-
  annotations:
    olm.providedAPIs: Xl.v1.charts.helm.k8s.io
  name: turbonomic-operator-group
  namespace: $NAMESPACE
spec:
  targetNamespaces:
    - $NAMESPACE

EOF

sleep 3

### Create secrets
echo "-----------------------------------"
echo "1.3. Create secrets"
echo "-----------------------------------"

oc adm policy add-cluster-role-to-user cluster-admin -z t8c-operator
oc adm policy add-cluster-role-to-user cluster-admin -z default


echo "Process completed .... "

}

