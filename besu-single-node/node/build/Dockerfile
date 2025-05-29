FROM gradle:8.11-jdk21

RUN apt-get update && apt-get install -y perl docker.io

WORKDIR /besu

# Clone Besu source code
RUN git clone --recursive --branch 25.4.1 https://github.com/hyperledger/besu.git .

# Disables the enforcement of a maximum code size limit
RUN perl -0777 -i -pe 's|LOG.trace\(|LOG.info\(|g' evm/src/main/java/org/hyperledger/besu/evm/contractvalidation/MaxCodeSizeRule.java \
 && perl -0777 -i -pe 's|Optional.of|Optional.empty\(\); // Optional.of|g' evm/src/main/java/org/hyperledger/besu/evm/contractvalidation/MaxCodeSizeRule.java

ENTRYPOINT ["./gradlew", "-Pversion=25.4.1"]

CMD ["distTar"]
