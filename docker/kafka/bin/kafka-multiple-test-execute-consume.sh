#!/bin/bash

docker exec -it kafka-multiple01 kafka-console-consumer --topic my-topic --bootstrap-server kafka-multiple01:9092