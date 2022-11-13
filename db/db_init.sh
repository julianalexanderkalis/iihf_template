docker run --name iihf-db -e MYSQL_ALLOW_EMPTY_PASSWORD=1 -e MYSQL_USER=myuser -e MYSQL_DATABASE=iihf_db -p 3306:3306 -d mysql:8.0 
# give time to create/setup user and database
sleep 10
docker exec -i iihf-db mysql -uroot iihf_db < iihf_db.sql  
