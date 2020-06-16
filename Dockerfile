# https://github.com/nodejs/docker-node/blob/master/14/alpine3.12/Dockerfile
# https://github.com/caddyserver/caddy-docker/blob/master/alpine/Dockerfile

FROM node:current-alpine

LABEL org.opencontainers.image.title=@LeaskH

RUN apk add --no-cache ca-certificates mailcap
RUN set -eux; \
    mkdir -p \
    /config/caddy \
    /data/caddy \
    /etc/caddy \
    /usr/share/caddy \
    /app/public;

ADD Caddyfile /etc/caddy/Caddyfile
ADD index.html /app/public/index.html

# https://github.com/caddyserver/caddy/releases
ENV CADDY_VERSION v2.0.0

RUN set -eux; \
    wget -O /tmp/caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.0.0/caddy_2.0.0_linux_amd64.tar.gz"; \
    tar x -z -f /tmp/caddy.tar.gz -C /usr/bin caddy; \
    rm -f /tmp/caddy.tar.gz; \
    chmod +x /usr/bin/caddy; \
    caddy version

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

VOLUME /config
VOLUME /data

WORKDIR /app

EXPOSE 80
EXPOSE 443
EXPOSE 2019

ENTRYPOINT []

CMD caddy run --config /etc/caddy/Caddyfile --adapter caddyfile & node index.js
