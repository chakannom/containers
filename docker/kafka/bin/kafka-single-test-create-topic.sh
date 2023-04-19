#!/bin/bash

docker exec -it kafka-single kafka-topics --create --topic my-topic --bootstrap-server kafka-single:9092 --replication-factor 1 --partitions 1

docker exec -it kafka-single kafka-topics --describe --topic my-topic --bootstrap-server kafka-single:9092

