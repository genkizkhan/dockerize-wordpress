docker build -t wplocal:latest .

docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v ./web/app/plugins:/var/www/html/wp-content/plugins \
  -v ./web/app/themes:/var/www/html/wp-content/themes \
  -e WORDPRESS_DB_PASSWORD=dbpassword \
  -e WORDPRESS_ADMIN_PASSWORD=adminroot \ 
  wplocal:latest


docker run -d \
  --name mysql-container \
  --network wplocal-network \
  -e MYSQL_ROOT_PASSWORD=yourpassword \
  -p 3307:3306 \
  mysql:latest