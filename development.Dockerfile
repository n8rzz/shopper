FROM ruby:2.6.4-alpine

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git bash"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY Gemfile* package.json yarn.lock $RAILS_ROOT/

WORKDIR $RAILS_ROOT

RUN gem install bundler && \
    bundle config --global frozen 1 && \
    bundle install -j4 --retry 3 --path=vendor/bundle && \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    rm -rf vendor/bundle/ruby/2.6.0/cache/*.gem && \
    find vendor/bundle/ruby/2.6.0/gems/ -name "*.c" -delete && \
    find vendor/bundle/ruby/2.6.0/gems/ -name "*.o" -delete
RUN yarn install

COPY . .

COPY script/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
