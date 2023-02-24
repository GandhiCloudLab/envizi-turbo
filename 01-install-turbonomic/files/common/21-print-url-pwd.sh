#!/usr/bin/env bash

function print_url_pwd () {

echo "----------------------------------------------------------------------"
echo "8. Printing Turbonomic console access details..."
echo "----------------------------------------------------------------------"

MY_URL=$(oc get route -n $NAMESPACE nginx -o jsonpath={.spec.host})

echo "===================================================================================="
echo "URL : https://$MY_URL"
echo "USER: administrator"
echo "===================================================================================="

}