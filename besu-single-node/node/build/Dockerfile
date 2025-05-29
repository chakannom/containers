FROM gradle:8.11-jdk21

RUN apt-get update && apt-get install -y perl docker.io && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Update ca-certificates
RUN openssl s_client -showcerts -connect services.gradle.org:443 </dev/null 2>/dev/null | \
    openssl x509 -outform PEM > /usr/local/share/ca-certificates/services-gradle-org.crt && \
    update-ca-certificates && \
    openssl s_client -showcerts -connect hyperledger.jfrog.io:443 </dev/null 2>/dev/null | \
    openssl x509 -outform PEM > /usr/local/share/ca-certificates/hyperledger-jfrog-io.crt && \
    update-ca-certificates

WORKDIR /besu

# Clone Besu source code
RUN git clone --recursive --branch 25.4.1 https://github.com/hyperledger/besu.git .

# Disables the enforcement of a maximum code size limit
RUN perl -0777 -i -pe 's|LOG.trace\(|LOG.info\(|g' evm/src/main/java/org/hyperledger/besu/evm/contractvalidation/MaxCodeSizeRule.java && \
    perl -0777 -i -pe 's|Optional.of|Optional.empty\(\); // Optional.of|g' evm/src/main/java/org/hyperledger/besu/evm/contractvalidation/MaxCodeSizeRule.java

ENTRYPOINT ["./gradlew", "-Pversion=25.4.1"]

CMD ["distTar"]
