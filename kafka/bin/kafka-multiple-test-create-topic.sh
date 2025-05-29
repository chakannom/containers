#!/bin/bash

docker exec -it kafka-multiple01 kafka-topics --create --topic my-topic --bootstrap-server kafka-multiple01:9092 --replication-factor 3 --partitions 2

docker exec -it kafka-multiple01 kafka-topics --describe --topic my-topic --bootstrap-server kafka-multiple01:9092

