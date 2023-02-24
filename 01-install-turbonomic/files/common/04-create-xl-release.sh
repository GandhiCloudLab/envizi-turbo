#!/usr/bin/env bash

function create_xl_release() {

### Install Turbonomic operator (Subscription)
echo "----------------------------------------------------------------------"
echo "2. Install XL Release "
echo "----------------------------------------------------------------------"

MY_UID=$(oc describe project $NAMESPACE | grep openshift.io/sa.scc.uid-range) 
# MY_UID="openshift.io/sa.scc.uid-range=1000640000/10000"
MY_UID=${MY_UID#*=}
MY_UID=${MY_UID%/1*}
echo $MY_UID


oc delete clusterrolebinding turbo-all-binding

cat << EOF | oc apply -f -
apiVersion: charts.helm.k8s.io/v1
kind: Xl
metadata:
  name: xl-release
  namespace: $NAMESPACE
spec:
  rhv:
    enabled: false
  servicenow:
    enabled: true
  websphere:
    enabled: true
  jvm:
    enabled: true
  actionscript:
    enabled: true
  xen:
    enabled: true
  mysql:
    enabled: true
  global:
    customImageNames: false
    pullPolicy: Always
    repository: registry.connect.redhat.com/turbonomic
    securityContext:
      fsGroup: $MY_UID
    tag: 8.7.5
  awslambda:
    enabled: true
  tomcat:
    enabled: true
  grafana:
    adminPassword: turbo4test
    enabled: true
    grafana.ini:
      database:
        password: turbo4test
        type: postgres
  xtremio:
    enabled: false
  extractor:
    enabled: true
  netapp:
    enabled: true
  vplex:
    enabled: true
  ucs:
    enabled: true
  udt:
    enabled: true
  tetration:
    enabled: true
  mssql:
    enabled: true
  apic:
    enabled: true
  nutanix:
    enabled: true
  weblogic:
    enabled: true
  prometheus:
    enabled: true
  hyperv:
    enabled: false
  vcenter:
    enabled: true
  oneview:
    enabled: true
  vmax:
    enabled: false
  instana:
    enabled: true
  reporting:
    enabled: true
  azure:
    enabled: true
  actionstream-kafka:
    enabled: true
  aix:
    enabled: true
  istio:
    enabled: true
  scaleio:
    enabled: false
  ucsdirector:
    enabled: true
  kubeturbo:
    enabled: true
  datadog:
    enabled: true
  wmi:
    enabled: true
  platform:
    enabled: true
  properties:
    extractor:
      grafanaAdminPassword: turbo4test
  newrelic:
    enabled: true
  flashsystems:
    enabled: true
  ui:
    enabled: true
  terraform:
    enabled: true
  gcp:
    enabled: true
  appdynamics:
    enabled: true
  baremetal:
    enabled: true
  vmm:
    enabled: false
  webhook:
    enabled: true
  jboss:
    enabled: true
  pure:
    enabled: true
  prometurbo:
    enabled: true
  ibmstorage-flashsystem:
    enabled: true
  postgres:
    enabled: true
    securityContext:
      fsGroup: $MY_UID
      runAsUser: $MY_UID
  nginx:
    httpsRedirect: false
    nginxIsPrimaryIngress: false
  horizon:
    enabled: true
  nginxingress:
    enabled: true
  flexera:
    enabled: true
  timescaledb:
    enabled: true
    securityContext:
      fsGroup: $MY_UID
      runAsUser: $MY_UID
  appinsights:
    enabled: true
  fluent-bit:
    enabled: true
  dynatrace:
    enabled: true
  aws:
    enabled: true
  openshiftingress:
    enabled: true
  snmp:
    enabled: true
  oracle:
    enabled: true  
EOF

sleep 5

echo "Process completed .... "

}
