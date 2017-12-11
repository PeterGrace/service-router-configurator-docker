#!/bin/sh

while true
do
    etcdctl --endpoints "$ETCDSERVERS" watch -r /registry/services/specs > /dev/null \
        && echo "$(date): Kubernetes service updated" \
        && /usr/local/bin/service-router-configurator --etcd-host "$ETCDSERVERS" --etcd-path /service-router/haproxy-config apply
done
