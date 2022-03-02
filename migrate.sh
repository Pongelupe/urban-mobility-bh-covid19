#! /bin/bash
docker run --net=host --rm \
    -v $(pwd)/migrations:/flyway/sql \
    -v $(pwd)/conf:/flyway/conf \
    flyway/flyway \
    migrate
