#!/bin/bash

kill -9 "$(cat deploy.pid)"

nohup ./deploy.sh >deploy.log &
echo $! >deploy.pid
