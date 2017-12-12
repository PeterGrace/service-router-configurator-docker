#!/bin/sh

kubectl config set-credentials $K8S_CLUSTER_USER --token=$K8S_CLUSTER_TOKEN
kubectl config set-cluster $K8S_CLUSTER_NAME --server=$K8S_CLUSTER_URL --certificate-authority=/ca.crt
kubectl config set-context default --cluster=$K8S_CLUSTER_NAME --user=$K8S_CLUSTER_USER
kubectl config use-context default

while true
do
    ETCDCTL_API=3 etcdctl --endpoints "$ETCDSERVERS" watch "/registry/services/specs" --prefix=true >/dev/null \
        && echo "$(date): Kubernetes service updated" \
        && /usr/local/bin/service-router-configurator --etcd-host "$ETCDSERVERS" --etcd-path /service-router/haproxy-config apply
done
