#/bin/bash

docker run -p 2181:2181 -p 9092:9092 -d -t luck02/kafka:v12
