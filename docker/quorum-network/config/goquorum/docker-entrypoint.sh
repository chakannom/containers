#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

GENESIS_FILE="/data/qbft-standard-genesis.json"

cp -R /config/* /data
mkdir -p /data/keystore/

echo "Applying ${GENESIS_FILE} ..."
geth --nousb --verbosity 1 --datadir=/data init ${GENESIS_FILE}; 

cp /config/keys/accountKeystore /data/keystore/key;
cp /config/keys/nodekey /data/geth/nodekey;

echo "Using qbft for consensus algorithm..."
export CONSENSUS_ARGS="--mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints"
export QUORUM_API="istanbul"

export ADDRESS=$(grep -o '"address": *"[^"]*"' /config/keys/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')

touch /var/log/quorum/geth-$(hostname -i).log
cat /proc/1/fd/2 /proc/1/fd/1 > /var/log/quorum/geth-$(hostname -i).log &

exec geth \
--datadir /data \
--nodiscover \
--permissioned \
--verbosity 3 \
$CONSENSUS_ARGS \
--syncmode full --revertreason \
--metrics --pprof --pprof.addr 0.0.0.0 --pprof.port 9545 \
--networkid ${QUORUM_NETWORK_ID:-1337} \
--http --http.addr 0.0.0.0 --http.port 8545 --http.corsdomain "*" --http.vhosts "*" --http.api admin,eth,debug,miner,net,txpool,personal,web3,$QUORUM_API \
--ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.origins "*" --ws.api admin,eth,debug,miner,net,txpool,personal,web3,$QUORUM_API \
--port 30303 \
--identity ${HOSTNAME}-qbft \
--unlock ${ADDRESS} \
--allow-insecure-unlock \
--password /data/passwords.txt \
${ADDITIONAL_ARGS:-} \
2>&1