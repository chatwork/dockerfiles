FROM ruby:2.6

LABEL maintainer="adachi@chatwork.com"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

ENTRYPOINT ["/usr/local/bundle/bin/gratan"]
CMD ["--help"]
