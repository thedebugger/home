#!/usr/bin/env bash

ver=$1
tmp_dir=$(mktemp -d)

set -eox pipefail
# https://istio.io/latest/docs/examples/bookinfo/
kind delete cluster --name istio-testing
kind create cluster --name istio-testing
kubectl config use-context kind-istio-testing

cd $tmp_dir
curl -O "https://storage.googleapis.com/istio-prerelease/prerelease/${ver}/istio-${ver}-linux-arm64.tar.gz"
tar -xzvf "istio-${ver}-linux-arm64.tar.gz"
cd "istio-${ver}"
./bin/istioctl install --set profile=demo -y --set hub=gcr.io/istio-prerelease-testing

kubectl scale --replicas=0 "deployment/istio-egressgateway" -n istio-systems

kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services
kubectl get pods -w
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
