#!/bin/bash
echo 'building docker images'
 
docker-compose -f docker-compose.yml build
 
 curl -X GET http://localhost:5000/v2/_catalog
