FROM ruby:2.6.4-alpine as builder

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git bash"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV NODE_ENV=production

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY Gemfile* package.json yarn.lock $RAILS_ROOT/

WORKDIR $RAILS_ROOT

RUN gem install bundler && \
    bundle config --global frozen 1 && \
    bundle install --retry 3 --path=vendor/bundle --jobs 20 --without development test && \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    rm -rf vendor/bundle/ruby/2.6.0/cache/*.gem && \
    find vendor/bundle/ruby/2.6.0/gems/ -name "*.c" -delete && \
    find vendor/bundle/ruby/2.6.0/gems/ -name "*.o" -delete
RUN yarn install --production

COPY . .

RUN bundle exec rake SECRET_KEY_BASE=foo assets:precompile
RUN rm -rf node_modules tmp/cache app/assets vendor/assets spec

COPY script/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN date -u > BUILD_TIME

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
