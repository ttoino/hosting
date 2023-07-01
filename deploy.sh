#!/bin/bash

function refresh {
    git pull
    docker compose down
    docker compose up -d --build registry
    docker compose pull
    docker compose up -d --build
}

mkfifo ./webhook.fifo

eval "$(ssh-agent -s)"
ssh-add
refresh

while cat ./webhook.fifo > /dev/null; do
    refresh
done
