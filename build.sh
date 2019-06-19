#!/bin/bash
echo 'building docker images'
 
sudo docker-compose -f docker-compose.yml build
wait
 
 sudo curl -X GET http://localhost:5000/v2/_catalog
