#!/usr/bin/env bash

function create_subscription() {

### Install Turbonomic operator (Subscription)
echo "----------------------------------------------------------------------"
echo "2. Install Turbonomic operator (Subscription : t8c-certified)"
echo "----------------------------------------------------------------------"

cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: t8c-certified
  namespace: $NAMESPACE
spec:
  channel: stable
  installPlanApproval: Automatic
  name: t8c-certified
  source: certified-operators
  sourceNamespace: openshift-marketplace
  startingCSV: $STARTING_CSV
EOF

sleep 5

echo "Process completed .... "

}
