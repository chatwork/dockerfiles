# base dockerfile: https://raw.githubusercontent.com/fluent/fluentd-docker-image/master/v1.5/debian/Dockerfile

FROM ruby:2.6-slim-buster
LABEL maintainer "Ryo Sakamoto <sakamoto@chatwork.com>"
LABEL Description="Fluentd docker image"
LABEL version="v1.11.5"

ENV TINI_VERSION=0.18.0

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apt-get purge' has no effect
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
            ca-certificates \
 && buildDeps=" \
      make gcc g++ libc-dev \
      wget bzip2 gnupg dirmngr \
    " \
 && apt-get install -y --no-install-recommends $buildDeps \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install oj -v "3.3.10" \
 && gem install json -v "2.2.0" \
 && gem install fluentd -v "1.11.5" \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-$dpkgArch" \
 && wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
 && gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
 && rm -r /usr/local/bin/tini.asc \
 && chmod +x /usr/local/bin/tini \
 && tini -h \
 && wget -O /tmp/jemalloc-4.5.0.tar.bz2 https://github.com/jemalloc/jemalloc/releases/download/4.5.0/jemalloc-4.5.0.tar.bz2 \
 && cd /tmp && tar -xjf jemalloc-4.5.0.tar.bz2 && cd jemalloc-4.5.0/ \
 && ./configure && make \
 && mv lib/libjemalloc.so.2 /usr/lib \
 && gem install fluent-plugin-concat -v "2.3.0" \
 && gem install fluent-plugin-detect-exceptions -v "0.0.12" \
 && gem install grpc -v "1.34.0" \
 && gem install fluent-plugin-google-cloud -v "0.10.4" \
 && gem install fluent-plugin-kafka -v "0.9.6" \
 && gem install fluent-plugin-kinesis -v "3.1.0" \
 && gem install fluent-plugin-record-modifier -v "2.1.0" \
 && gem install fluent-plugin-record-reformer -v "0.9.1" \
 && gem install fluent-plugin-rewrite-tag-filter -v "2.2.0" \
 && gem install fluent-plugin-s3 -v "1.5.0" \
 && gem install fluent-plugin-systemd -v "1.0.2"\
 && gem install fluent-plugin-datadog -v "0.12.0"\
 && gem install fluent-plugin-cloudwatch-logs -v "0.7.3" \
 && gem install logfmt \
 && apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN groupadd -r fluent && useradd -r -g fluent fluent \
    # for log storage (maybe shared with host)
    && mkdir -p /fluentd/log \
    # configuration/plugins path (default: copied from .)
    && mkdir -p /fluentd/etc /fluentd/plugins \
    && chown -R fluent /fluentd && chgrp -R fluent /fluentd

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/
Run chmod 755 /bin/entrypoint.sh

ENV FLUENTD_CONF="fluent.conf"

ENV LD_PRELOAD="/usr/lib/libjemalloc.so.2"
EXPOSE 24224 5140

USER fluent
ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]

