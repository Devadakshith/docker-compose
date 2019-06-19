#!/bin/bash
VERSION=$(date +%Y-%m-%d)
REPOSITORY="localhost:5000"

echo '****building docker images****'
 
wait
sudo docker-compose -f docker-compose.yml build
 
sudo curl -X GET http://localhost:5000/v2/_catalog
 
echo  $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}')
  
  for pat_repo_image in $(docker images | grep -i tomcat | awk '{printf "%s:%s\n",$1,$2}'); do
    echo "FROM FIRST ECHO $pat_repo_image"
    echo "REPO=====>  $REPOSITORY"

	#pat_dev_image=$(echo "$pat_repo_image" | sed "s/latest/$REPOSITORY/")
	
	pat_dev_image=$(echo "$pat_repo_image" | awk '{print "$REPOSITORY"$pat_dev_image}')
	echo "END ==> $pat_dev_image"
	
	echo $(docker images | awk '{printf "%s:%s\n",$1,$2}')

  done
