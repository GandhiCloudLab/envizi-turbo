#!/usr/bin/env bash

source ./00-config.sh

source ./common/01-create-namespace-secret-catalog-source.sh
source ./common/02-create-subscription.sh
source ./common/03-verify-operator-pod.sh
source ./common/04-create-xl-release.sh
source ./common/06-verify-pods-count.sh
source ./common/21-print-url-pwd.sh


install_main() {

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "******************************************************************************************"
  echo " Turbonomic Installation started ....$date1"
  echo "******************************************************************************************"
  
  create_namespace_secret_catalog_source
  create_subscription
  verify_operator_pod
  if [[ $GLOBAL_POD_VERIFY_STATUS == "true" ]]; then 
    create_xl_release
    verify_pods_count
    if [[ $GLOBAL_POD_VERIFY_STATUS == "true" ]]; then 
      print_url_pwd
    fi
  fi

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "******************************************************************************************"
  echo " Turbonomic Installation completed ....$date1"
  echo "******************************************************************************************"

}

install_main