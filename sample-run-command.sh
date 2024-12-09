#   Run this first
docker build -t wplocal:latest .



#   Run this second
docker run -d \
  --name mysql-container \
  --network wplocal-network \
  -e MYSQL_ROOT_PASSWORD=yourpassword \
  -p 3307:3306 \
  mysql:latest



#   Run this third
#   for macOS host
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v ./web/app/plugins:/var/www/html/wp-content/plugins \
  -v ./web/app/themes:/var/www/html/wp-content/themes \
  wplocal:latest


#   Run this third
#   for Windows host
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v <drive:>/<path>/<to>/<your>/<project>/<folder-name>/web/app/plugins:/var/www/html/wp-content/plugins \
  -v <drive:>/<path>/<to>/<your>/<project>/<folder-name>/web/app/themes:/var/www/html/wp-content/themes \
  wplocal:latest



