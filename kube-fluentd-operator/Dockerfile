# builder image
FROM golang:1.12 as builder

ARG KFO_VERSION="v1.10.0"

WORKDIR /go/src/github.com/vmware/kube-fluentd-operator/config-reloader
RUN go get -u github.com/golang/dep/cmd/dep
COPY kube-fluentd-operator/config-reloader/. .

# Speed up local builds where vendor is populated
RUN [ -d vendor/github.com ] || make dep; true
RUN make test
RUN make build VERSION=${KFO_VERSION}

# base file https://github.com/vmware/kube-fluentd-operator/blob/master/base-image/Dockerfile
FROM fluent/fluentd:v1.7.3-debian-1.0

LABEL version="v1.7.3-v1.10.0"
LABEL maintainer="sakamoto@chatwork.com"

USER root

# start with a valid empty file
COPY files/failsafe.conf /fluentd/failsafe.conf
COPY files/entrypoint.sh /fluentd/entrypoint.sh
RUN chmod 755 /fluentd/entrypoint.sh

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libffi-dev" \
      && apt-get update \
      && apt-get install \
       -y --no-install-recommends \
      $buildDeps \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && fluent-gem install ffi -v "1.11.1" \
    && fluent-gem install fluent-plugin-concat -v "2.3.0" \
    && fluent-gem install fluent-plugin-detect-exceptions -v "0.0.12" \
    && fluent-gem install fluent-plugin-kafka -v "0.9.6" \
    && fluent-gem install fluent-plugin-kinesis -v "3.1.0" \
    && fluent-gem install fluent-plugin-record-modifier -v "2.0.1" \
    && fluent-gem install fluent-plugin-record-reformer -v "0.9.1" \
    && fluent-gem install fluent-plugin-rewrite-tag-filter -v "2.2.0" \
    && fluent-gem install fluent-plugin-s3 -v "1.1.11" \
    && fluent-gem install fluent-plugin-systemd -v "1.0.2"\
    && fluent-gem install fluent-plugin-datadog -v "0.11.0"\
    && fluent-gem install fluent-plugin-cloudwatch-logs -v "0.7.3" \
    && fluent-gem install fluent-plugin-elasticsearch -v "3.5.2"\
    && fluent-gem install fluent-plugin-bigquery -v "2.1.0"\
    && fluent-gem install fluent-plugin-kubernetes -v "0.3.1"\
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter -v "2.2.0" \
    && fluent-gem install fluent-plugin-logentries -v "0.2.10"\
    && fluent-gem install fluent-plugin-mail -v "0.3.0"\
    && fluent-gem install fluent-plugin-out-http-ext -v "0.1.10"\
    && fluent-gem install fluent-plugin-route -v "1.0.0"\
    && fluent-gem install fluent-plugin-scribe -v "1.0.0"\
    && fluent-gem install fluent-plugin-secure-forward -v "0.4.5"\
    && fluent-gem install logfmt -v "0.0.8"\
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

# for kube-fluentd-operator https://github.com/vmware/kube-fluentd-operator/blob/v1.9.0/log-router/templates/daemonset.yaml#L92
Run ln -s /usr/local/bundle/bin/fluentd /usr/local/bin/fluentd

RUN rm -f kube-fluentd-operator

#RUN groupadd -r fluent && useradd -r -g fluent fluent \
#    # for log storage (maybe shared with host)
#RUN mkdir -p /fluentd/log \
#    # configuration/plugins path (default: copied from .)
#    && mkdir -p /fluentd/etc /fluentd/plugins \
#    && chown -R fluent /fluentd && chgrp -R fluent /fluentd

WORKDIR /home/fluent

ENTRYPOINT ["/fluentd/entrypoint.sh"]
