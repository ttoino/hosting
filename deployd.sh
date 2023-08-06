#!/bin/bash

kill -9 "$(cat deploy.pid)"

eval "$(ssh-agent -s)"
ssh-add

nohup ./deploy.sh >deploy.log &
echo $! >deploy.pid
