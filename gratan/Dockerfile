FROM ruby:2.6

ARG GRATAN_VERSION=0.3.2
LABEL version="${GRATAN_VERSION}"

LABEL maintainer="adachi@chatwork.com"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENTRYPOINT ["/usr/local/bundle/bin/gratan"]
CMD ["--version"]
