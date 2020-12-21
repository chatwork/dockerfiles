FROM datadog/docker-dd-agent:12.7.5327

ARG DOCKER_VERSION=12.7.5327

LABEL version="${DOCKER_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN rm /etc/dd-agent/conf.d/docker_daemon.yaml
RUN rm /etc/dd-agent/conf.d/*.default
