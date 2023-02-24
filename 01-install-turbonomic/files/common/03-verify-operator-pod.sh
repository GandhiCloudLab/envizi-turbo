#!/usr/bin/env bash

function verify_operator_pod() {

echo "----------------------------------------------------------------------"
echo "3. Verify operator installation... (pod : t8c-operator) "
echo "----------------------------------------------------------------------"
echo "Executing the below command ...."
echo "oc get pods -n $NAMESPACE | grep t8c-operator."
echo "The output should be like this...."
echo "t8c-operator-5c84769d8f-r9gqp                           1/1     Running   0          6m27s"

export GLOBAL_POD_VERIFY_STATUS=false

RESOURCE_COUNT=0
RESOURCE_FOUND=false
LOOP_COUNT=0
MAX_LOOP_COUNT=180

while [[ ${RESOURCE_FOUND} == "false" && $LOOP_COUNT -lt $MAX_LOOP_COUNT ]]; do
    LOOP_COUNT=$((LOOP_COUNT+1))
    echo "Trying for $LOOP_COUNT / $MAX_LOOP_COUNT."

    RESOURCE_COUNT=$(oc get pods -n ${NAMESPACE} | grep t8c-operator | grep -c Running)

    if [[ $RESOURCE_COUNT -gt 0 ]]; 
    then
        RESOURCE_FOUND=true
    else
        RESOURCE_FOUND=false
        sleep 5
    fi
done

if [[ $RESOURCE_FOUND == "true" ]]; 
then
    echo "Resource found (t8c-operator pod)"
    export GLOBAL_POD_VERIFY_STATUS=true
else
    echo "Resource Not found (t8c-operator pod). Terminating.. Retry the install "
    export GLOBAL_POD_VERIFY_STATUS=false
fi


echo "Verify Status : ${GLOBAL_POD_VERIFY_STATUS} "


echo "Process completed .... "

}