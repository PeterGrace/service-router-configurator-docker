#!/bin/sh

while true
do
    ETCDCTL_API=3 etcdctl --debug --endpoints "$ETCDSERVERS" watch /registry/services/specs \
        && echo "$(date): Kubernetes service updated" \
        && /usr/local/bin/service-router-configurator --etcd-host "$ETCDSERVERS" --etcd-path /service-router/haproxy-config apply
done
