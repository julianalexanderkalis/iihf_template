# create new docker image and container named iihf-db that runs mysql 8.0, sets several environment variables and maps the docker port to the host network port of 3306 
docker run --name iihf-db -e MYSQL_ALLOW_EMPTY_PASSWORD=1 -e MYSQL_USER=myuser -e MYSQL_DATABASE=iihf_db -p 3306:3306 -d mysql:8.0 
# give time to create/setup user and database
sleep 10
# inserts the 'iihf_db.sql' file into the newly created docker container
docker exec -i iihf-db mysql -uroot iihf_db < iihf_db.sql  
