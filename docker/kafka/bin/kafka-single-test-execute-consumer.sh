#!/bin/bash

docker exec -it kafka-single kafka-console-consumer --topic my-topic --bootstrap-server kafka-single:9092