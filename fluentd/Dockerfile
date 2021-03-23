ARG FLUENTD_IMAGE_VERSION="1.12.1-debian-1.0"

FROM fluent/fluentd:v${FLUENTD_IMAGE_VERSION}

ARG FLUENTD_VERSION="1.12.1"

LABEL version="${FLUENTD_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

USER root
RUN buildDeps="make gcc g++ libc-dev ruby-dev" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && echo 'gem: --no-document' >> /etc/gemrc \
    # official plugins
    && fluent-gem install fluent-plugin-s3 -v "1.5.0" \
    && fluent-gem install fluent-plugin-kafka -v "0.13.0" \
    && fluent-gem install fluent-plugin-elasticsearch -v "4.0.8" \
    && fluent-gem install fluent-plugin-mongo -v "1.4.0" \
    && fluent-gem install fluent-plugin-rewrite-tag-filter -v "2.3.0" \
    && fluent-gem install fluent-plugin-webhdfs -v "1.2.4" \
    # kubernetes plugins
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter -v "2.4.1" \
    && fluent-gem install fluent-plugin-prometheus -v "1.7.3" \
    # aws plugin
    && fluent-gem install fluent-plugin-ec2-metadata -v "0.1.3" \
    && fluent-gem install fluent-plugin-cloudwatch-logs -v "0.9.4" \
    && fluent-gem install fluent-plugin-aws-elasticsearch-service -v "1.0.0" \
    # gcp plugin
    && fluent-gem install fluent-plugin-bigquery -v "2.2.0" \
    && fluent-gem install fluent-plugin-google-cloud -v "0.10.4" \
    # other plugin
    && fluent-gem install fluent-plugin-detect-exceptions -v "0.0.13" \
    && SUDO_FORCE_REMOVE=yes \
         apt-get purge -y --auto-remove \
                       -o APT::AutoRemove::RecommendsImportant=false \
                       $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]
