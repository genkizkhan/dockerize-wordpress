# Dockerize WordPress

Dockerizing WordPress involves setting up a containerized environment for both WordPress and its database.

## Prerequisites

1. Ensure Docker Desktop, HeidiSQL, VSCode, Git is installed on your system.
2. Basic understanding of Git and have a Github account.
3. Basic understanding of Docker.

## Step 1: Create a Project Directory

1. Open a terminal.
2. Create a directory for your project:

```bash
mkdir dockerize-wp
cd dockerize-wp

```

## Step 2: Clone the repository

1. In the created project directory, clone the repository.

```bash
git clone https://github.com/genkizkhan/dockerize-wordpress.git

```

## Step 3: Create a wordpress Docker Image

The docker image created will be based on the `Dockerfile` configuration.

```bash
docker build -t wplocal:latest .

```

## Step 4: Create a Docker Network

To allow the WordPress and MySQL containers to communicate, create a Docker network.

```bash
docker network create wplocal-network

```

- Run `docker network ls` to verify existing networks in Docker

## Step 5: Create a MySQL container

Take note of the port `-p` as it may cause a conflict, if an existing application uses it. Looking at the configuration below: `3307` is the host port while `3306` is the container port.

```bash
docker run -d \
  --name mysql-container \
  --network wplocal-network \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -p 3307:3306 \
  mysql:latest

```

## Step 6: Create a WordPress container (macOS)

For an iOS host:

```bash
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v ./web/app/plugins:/var/www/html/wp-content/plugins \
  -v ./web/app/themes:/var/www/html/wp-content/themes \
  wplocal:latest

```

For windows host:

```bash
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v C:/Users/NINA/Desktop/testing100/dockerize-wordpress/web/app/plugins:/var/www/html/wp-content/plugins \
  -v C:/Users/NINA/Desktop/testing100/dockerize-wordpress/web/app/plugins:/var/www/html/wp-content/themes \
  wplocal:latest

```

- `-p` : Map port `8886` on the host to port `80` in the container. Update port `8886` as necessesary if already in use.

## Step 7: Configure HeidiSQL

To connect MySQL container as database of WordPress.

```bash
  hostname: localhost
  port: 3307
  username: root
  password: root_password

```

- test the connection using `HeidiSQL`.

## Step 8: Configure WordPress installation

1. Open a web browser.
2. Navigate to `http:localhost:8886`.
3. Complete the WordPress setup using the data defined below:

```bash
  database: localhost
  username: root
  password: root_password
  host: wp-container

```

## Conclusion

You have now Dockerized WordPress. Thank you and enjoy coding!
