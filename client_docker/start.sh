#!/bin/bash

docker compose up -d

# `cockroach init` commands for the three clusters
docker exec -it roach1 ./cockroach init --insecure

# run the init sql on roach1
# note that the init/dbinit.sql is copied to only roach1
# you need to modify the docker-compose.yml
# if you want to copy to roach2 and roach3 as well
docker exec -it roach1 ./cockroach sql -f ./dbinit.sql --user=root --insecure

docker start -i client
