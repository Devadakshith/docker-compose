#!/bin/bash
VERSION=$(date +%Y-%m-%d)
REPOSITORY="localhost:5000/"


echo '****building docker images****'
 
wait
sudo docker-compose -f docker-compose.yml build
 
sudo curl -X GET http://localhost:5000/v2/_catalog
 
echo  $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}')
  
  for pat_repo_image in $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}'); do
    echo "FROM FIRST ECHO $pat_repo_image"
    echo "REPO=====>  $REPOSITORY"

	REPO_IMAGE="$REPOSITORY$pat_repo_image"
	echo "END ==> $REPO_IMAGE"
	sudo docker tag $pat_repo_image $REPO_IMAGE
	
	echo $(docker images | awk '{printf "%s:%s\n",$1,$2}')
	
	docker push $REPO_IMAGE
	
	sudo curl -X GET http://localhost:5000/v2/_catalog

  done
