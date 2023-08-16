#!/bin/bash

FIFO=./webhook.fifo
GIT=git
DOCKER=docker

mkfifo $FIFO

git pull
docker compose down -v --remove-orphans
docker compose up -d --build registry
docker compose pull
docker compose up -d --build

while true; do
    read -r command arg <"$FIFO"

    if [[ "$command" == "$GIT" ]]; then
        git pull
        docker compose down -v --remove-orphans
        docker compose up -d --build
    elif [[ "$command" == "$DOCKER" ]]; then
        docker compose pull "$arg"
        docker compose down -v "$arg"
        docker compose up -d --build
    else 
        echo "Unknown command: $command $arg"
    fi
done
