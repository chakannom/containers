FROM alpine:latest

RUN apk add --no-cache \
        bash \
        git \
        make \
        openssl \
        docker-cli \
        docker-cli-compose

COPY certs/*.* /usr/local/share/ca-certificates/

RUN update-ca-certificates

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /multica

ENTRYPOINT ["/entrypoint.sh"]
