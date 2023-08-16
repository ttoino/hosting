#!/bin/bash

kill -9 "$(cat deploy.pid)"

eval "$(ssh-agent -s)"
ssh-add

(nohup ./deploy.sh | ts "[%Y-%m-%dT%H:%M:%S]") >logs/deploy.log &
echo $! >deploy.pid
