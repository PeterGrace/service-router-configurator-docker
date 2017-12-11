svc_router_config
##################
1. `go get go.mikenewswanger.com/service-router-configurator`
2. `go get github.com/coreos/etcd/etcdctl`
3. `cp $GOHOME/bin/etcdctl $GOHOME/bin/service-router-configurator .`
4. `docker build -t image.name .`
5. `docker push image.name`
