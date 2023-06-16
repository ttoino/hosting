#!/bin/bash

function refresh {
    git pull
    docker compose up -d --build
}

mkfifo ./webhook.fifo

ssh-add
refresh

while cat ./webhook.fifo > /dev/null; do
    refresh
done
