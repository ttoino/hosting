#!/bin/bash

FIFO=./webhook.fifo
GIT=git
DOCKER=docker

mkfifo $FIFO

git pull
docker compose down -v
docker compose up -d --build registry
docker compose pull
docker compose up -d --build

while true; do
    read -ra line

    if [[ "${line[0]}" == "$GIT" ]]; then
        git pull
        docker compose down -v
        docker compose up -d --build
    elif [[ "${line[0]}" == "$DOCKER" ]]; then
        docker compose pull "${line[1]}"
        docker compose down -v "${line[1]}"
        docker compose up -d --build
    fi
done <$FIFO
