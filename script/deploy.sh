#!/bin/sh

ssh -o StrictHostKeyChecking=no root@$DO_IP << 'ENDSSH'
  cd /app
  docker-compose stop
  docker-compose up --build -d
ENDSSH
