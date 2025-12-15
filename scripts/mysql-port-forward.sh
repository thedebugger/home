#!/usr/bin/env bash
set -e
TEMP_POD_NAME=mysql-jump-server-primary
LOCAL_PORT=3308
REMOTE_HOST=${1:-}
REMOTE_PORT=3301
function cleanup {
  echo ""
  kubectl delete pod/$TEMP_POD_NAME -n proxysql --grace-period 1 --wait=false
}
trap cleanup EXIT
kubectl run -n proxysql --restart=Never --image=alpine/socat $TEMP_POD_NAME -- -d -d tcp-listen:$REMOTE_PORT,fork,reuseaddr tcp-connect:$REMOTE_HOST:$REMOTE_PORT
kubectl wait --for=condition=Ready -n proxysql pod/$TEMP_POD_NAME
kubectl port-forward -n proxysql pod/$TEMP_POD_NAME $LOCAL_PORT:$REMOTE_PORT
