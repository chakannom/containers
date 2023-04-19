#!/bin/bash

docker exec -it kafka-single kafka-console-producer --topic my-topic --broker-list kafka-single:9092