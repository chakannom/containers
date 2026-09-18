FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        git \
        jq \
        docker.io \
    && rm -rf /var/lib/apt/lists/*

COPY certs/*.* /usr/local/share/ca-certificates/

RUN update-ca-certificates

RUN curl -fsSL https://raw.githubusercontent.com/multica-ai/multica/main/scripts/install.sh | bash

COPY bin/opencode /usr/local/bin/opencode
COPY bin/hermes /usr/local/bin/hermes
COPY bin/get-pat /usr/local/bin/get-pat
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x \
    /usr/local/bin/opencode \
    /usr/local/bin/hermes \
    /usr/local/bin/get-pat \
    /entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
