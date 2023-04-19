#!/bin/bash

if ! grep -Fq "mongodb-replica01" /etc/hosts
then
  echo "You must edit /etc/hosts"
  echo "-----------------------"
  echo "127.0.0.1 mongodb-replica01"
  echo "127.0.0.1 mongodb-replica02"
  echo "127.0.0.1 mongodb-replica03"
  echo "-----------------------"
  exit 0
fi

docker exec -it mongodb-replica01 mongosh --port 30001 --eval "rs.initiate({
    _id: \"mongo-replset\",
    members: [
      {_id: 0, host: \"mongodb-replica01:30001\"},
      {_id: 1, host: \"mongodb-replica02:30002\"},
      {_id: 2, host: \"mongodb-replica03:30003\"}
    ]
})"
