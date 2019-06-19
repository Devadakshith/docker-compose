#!/bin/bash
VERSION=$(date +%Y-%m-%d)

echo '****building docker images****'
 
wait
sudo docker-compose -f docker-compose.yml build
 
sudo curl -X GET http://localhost:5000/v2/_catalog
 
echo  $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}')
  
  for pat_repo_image in $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}'); do
    echo "$pat_repo_image"
	    pat_dev_image=$(echo "$pat_repo_image" | sed "s/$VERSION/latest/")
	echo "$pat_dev_image"
    # push images to Docker Registry
    #docker tag "$pat_repo_image" "$pat_dev_image"

  done
