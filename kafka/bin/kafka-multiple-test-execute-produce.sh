#!/bin/bash

docker exec -it kafka-multiple01 kafka-console-producer --topic my-topic --broker-list kafka-multiple01:9092