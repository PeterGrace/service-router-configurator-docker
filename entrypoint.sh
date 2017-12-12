#!/bin/sh

FIFO=${SVC_FIFO:-svc_fifo}

kubectl config set-credentials $K8S_CLUSTER_USER --token=$K8S_CLUSTER_TOKEN
kubectl config set-cluster $K8S_CLUSTER_NAME --server=$K8S_CLUSTER_URL --certificate-authority=/ca.crt
kubectl config set-context default --cluster=$K8S_CLUSTER_NAME --user=$K8S_CLUSTER_USER
kubectl config use-context default


mkfifo $FIFO
ETCDCTL_API=3 etcdctl --endpoints "$ETCDSERVERS" watch "/registry/services/specs" --prefix=true  --interactive=false >> $FIFO 2>&1 &
while read line
do
        echo "$(date): Kubernetes service updated" \
        && /usr/bin/service-router-configurator --etcd-host "$ETCDSERVERS" --etcd-path /service-router/haproxy-config apply
done < $FIFO
