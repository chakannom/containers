FROM alpine:latest

RUN apk add --no-cache bash git make openssl \
        docker-cli docker-cli-compose

WORKDIR /multica

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]