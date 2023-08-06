#!/bin/bash

function refresh {
    git pull
    docker compose down -v
    docker compose up -d --build registry
    docker compose pull
    docker compose up -d --build
}

mkfifo ./webhook.fifo

refresh

while cat ./webhook.fifo > /dev/null; do
    refresh
done
