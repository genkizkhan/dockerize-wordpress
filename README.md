# Dockerize WordPress
Dockerizing WordPress involves setting up a containerized environment for both WordPress and its database.


## Prerequisites
1. Ensure Docker Desktop, HeidiSQL, VSCode, Git are installed on your system.
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
git clone https://github.com/genkizkhan/dockerize-wordpress.git .

```


## Step 3: Create a WordPress Docker Image
The docker image created will be base on the `Dockerfile` configuration.
```bash
docker build -t wplocal:latest .

```


## Step 4: Create a Docker Network
To allow the WordPress and MySQL containers to communicate, create a Docker network.
```bash
docker network create wplocal-network

```
- Run `docker network ls` to verify existing networks in Docker.



## Step 5: Create a MySQL container
Looking at the configuration below, take note of the port `-p 3307:3306` as it may cause a conflict. Port `3307` is the host port map to container port `3306`. Update port `3307` as necessesary if already in use.
```bash
docker run -d \
  --name mysql-container \
  --network wplocal-network \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -p 3307:3306 \
  mysql:latest

```
- You may change the `root_password` accordingly.


## Step 6: Create a WordPress container
For macOS host:
```bash
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v ./web/app/plugins:/var/www/html/wp-content/plugins \
  -v ./web/app/themes:/var/www/html/wp-content/themes \
  wplocal:latest

```

For Windows host:
```bash
docker run -d \
  -p 8886:80 \
  --name wp-container \
  --network wplocal-network \
  -v <drive:>/<path>/<to>/<your>/<project>/<folder-name>/web/app/plugins:/var/www/html/wp-content/plugins \
  -v <drive:>/<path>/<to>/<your>/<project>/<folder-name>/web/app/themes:/var/www/html/wp-content/themes \
  wplocal:latest

```
Update the file location to your project location.
- `-p` : Map port `8886` on the host to port `80` in the container. Update port `8886` as necessesary if already in use.
- `<drive:>/<path>/<to>/<your>/<project>/<folder-name>` : this path should reflect to the appropriate file location on your windows machine.
- To verify the correct file path being mounted, open docker desktop, navigate to `Containers`, select `wp-container` then click `Bind mounts` tab. It should shows the correct specified file path.



## Step 7: Configure HeidiSQL
To connect MySQL container as database of WordPress:
1. Open HeidiSQL
2. Create `New`- session in root folder, name it appropriately and configure with the settings below:

```bash
  network_type: MariaDB or MySQL (TCP/IP)
  hostname: localhost
  user: root
  password: root_password
  port: 3307

```
3. A new window will pop-up and should show the session you've created.
4. Right-click the session-name and create new database - `wordpress`. 



## Step 8: Configure WordPress installation
1. Open a web browser.
2. Navigate to `http:localhost:8886`.
3. If the page loads an error: `ERROR ESTABLISHING A DATABASE CONNECTION`, open docker desktop, navigate to `Containers`, select `wp-container` then click `Exec` tab. Delete the file `wp-config.php` by issuing the following command in the terminal.

    a. `ls` : to show all files at the current directory. Make sure that it contain the file `wp-config.php`.

    b. `rm -rf wp-config.php` : to forcibly remove `wp-config.php`. Verify that the file is successfully remove by issuing the `ls` command.

4. Navigate again to `http:localhost:8886` and it should load the WordPress installation page. Follow on-screen procedures and complete the WordPress setup using the data defined below:

```bash
  language: English

  database_name: wordpress
  database_username: root
  database_password: root_password
  database_host: mysql-container
  table_prefix: wp_

```
- Note: `database_name` is the database you've created at Step 7.
- `database_host` is the mysql container at docker



## Conclusion
You have now Dockerized WordPress. Thank you and enjoy coding!
