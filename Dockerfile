FROM alpine:latest
COPY service-router-configurator /usr/bin
COPY etcdctl /usr/bin
COPY kubectl /usr/bin
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
