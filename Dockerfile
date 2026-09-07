FROM php:7.4-alpine

#install all the system dependencies and enable PHP modules 
RUN apk add --no-cache \
    autoconf \
    g++ \
    make \
    git \
    icu-dev \
    libzip-dev \
    postgresql-dev \
    oniguruma-dev   # 🔑 required for mbstring

# Configure and install PHP extensions
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-install \
    intl \
    mbstring \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    zip \
    opcache \
  && rm -rf /var/cache/apk/*

  
#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

#COPY . /var/www/html

WORKDIR /var/www/html

# install all PHP dependencies
# clone Zuluru from GitHub (always latest main branch)
# Remove the copied folder
RUN rm -rf ./* \
  && git clone https://github.com/XtraTarTarSauce/Zuluru3 . \
  && composer install --no-interaction --no-dev --optimize-autoloader

  # Modify app.php file
RUN sed -i -e "s/'SECURITY_SALT'/'SECURITY_SALT', '5C2Yi3REBrXA5cN06dcH6VdAeJySm6RR'/" config/app.php && \
	# Make sessionhandler configurable via environment
	sed -i -e "s/'php',/env('SESSION_DEFAULTS', 'php'),/" config/app.php
	# Set write permissions for webserver

EXPOSE 80

CMD bin/cake server -H 0.0.0.0 -p 80
