FROM ruby:2.6.4-alpine AS builder

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY Gemfile* package.json yarn.lock ./
# install rubygem
COPY Gemfile Gemfile.lock $RAILS_ROOT/

RUN bundle config --global frozen 1 \
    && bundle install --without development:test:assets -j4 --retry 3 --path=vendor/bundle \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf vendor/bundle/ruby/2.6.0/cache/*.gem \
    && find vendor/bundle/ruby/2.6.0/gems/ -name "*.c" -delete \
    && find vendor/bundle/ruby/2.6.0/gems/ -name "*.o" -delete
RUN yarn install --production

COPY . .

RUN bin/rails webpacker:compile
RUN bin/rails assets:precompile
# Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache app/assets vendor/assets spec

############### Build step done ###############
FROM ruby:2.6.3-alpine

ARG RAILS_ROOT=/app
ARG PACKAGES="tzdata postgresql-client nodejs bash"

ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

COPY --from=builder $RAILS_ROOT $RAILS_ROOT

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

# FROM ruby:2.6.3 AS Builder

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev ghostscript curl
# RUN mkdir -p /usr/local/nvm
# RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
# RUN apt-get install -y nodejs
# RUN node -v
# RUN npm -v

# # Copy the Gemfile as well as the Gemfile.lock and install
# # the RubyGems. This is a separate step so the dependencies
# # will be cached unless changes to one of those two files
# # are made.
# RUN gem install bundler

# RUN mkdir -p /app
# WORKDIR /app

# ADD Gemfile* /app/

# RUN bundle config --global frozen 1 \
#  && bundle install --without development test -j4 --retry 3 \
#  # Remove unneeded files (cached *.gem, *.o, *.c)
#  && rm -rf /usr/local/bundle/cache/*.gem \
#  && find /usr/local/bundle/gems/ -name "*.c" -delete \
#  && find /usr/local/bundle/gems/ -name "*.o" -delete

# # COPY Gemfile Gemfile.lock package.json yarn.lock ./

# # RUN bundle install --jobs 20 --retry 5
# RUN npm install -g yarn
# # RUN yarn install --check-files
# COPY package.json yarn.lock /app/
# RUN yarn install

# # FROM builder

# ADD . ./

# RUN RAILS_ENV=production SECRET_KEY_BASE=foo rails assets:precompile
# RUN rm -rf node_modules tmp/cache app/assets vendor/assets lib/assets spec

# ###

# # FROM ruby:2.6.3-alpine

# # RUN apk add --update --no-cache \
# #     postgresql-client \
# #     imagemagick \
# #     tzdata \
# #     file \
# #     ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

# # Add user
# RUN addgroup -g 1000 -S app \
#  && adduser -u 1000 -S app -G app
# USER app

# # Copy app with gems from former build stage
# # COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
# # COPY --from=Builder --chown=app:app /app /app

# ENV RAILS_LOG_TO_STDOUT true
# ENV RAILS_SERVE_STATIC_FILES true
# ENV EXECJS_RUNTIME Disabled

# WORKDIR /app

# EXPOSE 3000

# # The main command to run when the container starts. Also
# # tell the Rails dev server to bind to all interfaces by
# # default.
# CMD ["rails", "server", "-b", "0.0.0.0"]
