- This is going to require that kubectl and etcdctl can talk to kubernetes and etcd, so you need to start container net=host.
- Before this works, one needs to make a basic service account for kubernetes to auth for kubectl.  To do this, you have to create a service account, copy the ca.crt from the service account and also the token (they're base64'd so you have to unencode the base64 when saving them) then pass them into the container via environment variables/volume mounts), then you must give that service account rights to edit the cluster:
  - `kubectl create rolebinding svcrouter-binding --clusterrole=view --serviceaccount=default:username`


1. `go get go.mikenewswanger.com/service-router-configurator`
2. `go get github.com/coreos/etcd/etcdctl` (Might need to build static: `CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' .`)
3. `cp $GOHOME/bin/etcdctl $GOHOME/bin/service-router-configurator .`
4. `docker build -t image.name .`
5. `docker push image.name`
