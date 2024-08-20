ARG FLUENTD_IMAGE_VERSION="1.17.1-debian-1.0"

FROM fluent/fluentd:v${FLUENTD_IMAGE_VERSION}

ARG FLUENTD_VERSION="1.17.1"

LABEL version="${FLUENTD_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

USER root
RUN buildDeps="make gcc g++ libc-dev ruby-dev" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && echo 'gem: --no-document' >> /etc/gemrc \
    # official plugins
    && fluent-gem install fluent-plugin-s3 -v "1.7.2" \
    && fluent-gem install fluent-plugin-rewrite-tag-filter -v "2.4.0" \
    # kubernetes plugins
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter -v "3.4.0" \
    && fluent-gem install fluent-plugin-prometheus -v "2.1.0" \
    # aws plugin
    && fluent-gem install fluent-plugin-ec2-metadata -v "0.1.3" \
    # gcp plugin
    && fluent-gem install fluent-plugin-bigquery -v "3.1.0" \
    # other plugin
    && fluent-gem install fluent-plugin-detect-exceptions -v "0.0.14" \
    && SUDO_FORCE_REMOVE=yes \
         apt-get purge -y --auto-remove \
                       -o APT::AutoRemove::RecommendsImportant=false \
                       $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]
