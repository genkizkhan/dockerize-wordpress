FROM wordpress:latest

# Install required packages including npm and curl
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    npm \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ENV WORDPRESS_DB_HOST=mysql.local:3306 \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_NAME=wordpress \
    WORDPRESS_DEBUG=1 \
    WORDPRESS_TABLE_PREFIX=wp_ \
    WORDPRESS_ADMIN_EMAIL=admin@example.com \
    WORDPRESS_ADMIN_USER=admin \
    WORDPRESS_SITE_URL=http://localhost:8886
    
# Copy project files into the container
COPY ./web/app/plugins /var/www/html/wp-content/plugins
COPY ./web/app/themes /var/www/html/wp-content/themes

# Set appropriate permissions
RUN chown -R www-data:www-data /var/www/html/wp-content \
    && chmod -R 755 /var/www/html/wp-content

# Expose port 80 for the web server
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
