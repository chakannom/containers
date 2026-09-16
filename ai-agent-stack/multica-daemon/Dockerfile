FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        git \
        docker.io \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/multica-ai/multica/main/scripts/install.sh | bash

COPY bin/opencode /usr/local/bin/opencode
COPY bin/hermes /usr/local/bin/hermes
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x \
    /usr/local/bin/opencode \
    /usr/local/bin/hermes \
    /entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
