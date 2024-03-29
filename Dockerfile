# Use the official PHP image as base
FROM php:8.3-fpm
# Set working directory inside the container
# WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_pgsql mbstring exif pcntl bcmath zip

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the Laravel application files to the container
WORKDIR /app
COPY . /app

#this fixes compose install error
ENV COMPOSER_ALLOW_SUPERUSER=1
# Install PHP dependencies
RUN composer update
RUN composer install --no-progress --no-scripts --no-interaction

# Copy the .env.example file and generate application key
RUN cp .env.example .env 
RUN php artisan key:generate

# Expose port 9000 to the outside world
EXPOSE 9000
#add execute permission to script
RUN chmod +x scripts/00-laravel-deploy.sh
# Command to run the Laravel application
CMD ["scripts/00-laravel-deploy.sh"]
#below is inside "/00-laravel-deploy.sh"
# CMD ["php", "artisan", "serve", "--host", "0.0.0.0"]