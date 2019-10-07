FROM registry.gitlab.com/n8rzz/shopper/app:latest as builder
FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils

ENV RAILS_ROOT /var/www/shopper

WORKDIR $RAILS_ROOT

RUN mkdir log

COPY --from=builder app/public public/
COPY nginx/nginx.conf /tmp/docker.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
