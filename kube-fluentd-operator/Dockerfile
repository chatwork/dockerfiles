# builder image
FROM golang:1.10 as builder

ARG KFO_VERSION="v1.7.0"
WORKDIR /go/src/github.com/vmware/kube-fluentd-operator/config-reloader
RUN go get -u github.com/golang/dep/cmd/dep
COPY kube-fluentd-operator/config-reloader/. .

# Speed up local builds where vendor is populated
RUN [ -d vendor/github.com ] || make dep; true
RUN make test
RUN make build VERSION=$(KFO_VERSION)

# base file https://github.com/vmware/kube-fluentd-operator/blob/master/base-image/Dockerfile
FROM fluent/fluentd:v1.2.5-debian

LABEL version v1.2.5-v1.7.0
LABEL maintainer "sakamoto@chatwork.com"

# start with a valid empty file
COPY files/failsafe.conf /fluentd/failsafe.conf
COPY files/entrypoint.sh /fluentd/entrypoint.sh
RUN chmod 755 /fluentd/entrypoint.sh

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libffi-dev" \
     && apt-get update \
     && apt-get upgrade -y \
     && apt-get install \
     -y --no-install-recommends \
     $buildDeps \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && fluent-gem install ffi \
    && fluent-gem install fluent-plugin-concat \
    && fluent-gem install fluent-plugin-detect-exceptions \
    && fluent-gem install fluent-plugin-elasticsearch \
    && fluent-gem install fluent-plugin-google-cloud \
    && fluent-gem install fluent-plugin-bigquery \
    && fluent-gem install fluent-plugin-kafka \
    && fluent-gem install fluent-plugin-kinesis \
    && fluent-gem install fluent-plugin-kubernetes \
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter \
    && fluent-gem install fluent-plugin-logentries \
    && fluent-gem install fluent-plugin-mail \
    && fluent-gem install fluent-plugin-out-http-ext \
    && fluent-gem install fluent-plugin-parser \
    && fluent-gem install fluent-plugin-record-modifier \
    && fluent-gem install fluent-plugin-record-reformer \
    && fluent-gem install fluent-plugin-remote_syslog \
    && fluent-gem install fluent-plugin-rewrite-tag-filter \
    && fluent-gem install fluent-plugin-route \
    && fluent-gem install fluent-plugin-s3 \
    && fluent-gem install fluent-plugin-scribe \
    && fluent-gem install fluent-plugin-secure-forward \
    && fluent-gem install fluent-plugin-systemd \
    && fluent-gem install logfmt \
    && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ADD https://raw.githubusercontent.com/fluent/fluentd-kubernetes-daemonset/master/docker-image/v0.12/debian-elasticsearch/plugins/parser_kubernetes.rb /fluentd/plugins
COPY files/plugins /fluentd/plugins
COPY kube-fluentd-operator/config-reloader/templates /templates
COPY kube-fluentd-operator/config-reloader/validate-from-dir.sh /bin/validate-from-dir.sh

COPY --from=builder /go/src/github.com/vmware/kube-fluentd-operator/config-reloader/config-reloader /bin/config-reloader
RUN chmod 755 /bin/config-reloader

RUN rm -f kube-fluentd-operator

USER root
WORKDIR /home/fluent

ENTRYPOINT ["/fluentd/entrypoint.sh"]
