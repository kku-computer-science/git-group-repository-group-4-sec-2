# ใช้ Base Image PHP 8 พร้อม Apache
FROM php:8.2-apache

# ติดตั้งแพ็กเกจที่จำเป็น และ PHP Extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    zip unzip curl git \
    default-mysql-client \
    libmagickwand-dev imagemagick \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mbstring exif pcntl bcmath mysqli pdo_mysql zip opcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# เปิดใช้งาน mod_rewrite ของ Apache
RUN a2enmod rewrite

# ตั้งค่า Timezone
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ตั้งค่า ServerName ใน Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# ติดตั้ง Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ติดตั้ง Laravel Installer ผ่าน Composer
RUN composer global require laravel/installer
ENV PATH="$PATH:/root/.composer/vendor/bin"

# กำหนด Directory การทำงาน
WORKDIR /var/www/html

# คัดลอกโค้ดโปรเจกต์ Laravel เข้าไปใน Docker
COPY ../ /var/www/html

# ตั้งค่า Permissions
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# เปิดพอร์ต 80
EXPOSE 80

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s \
    CMD curl -f http://localhost/ || exit 1

# คำสั่งเริ่มต้น
CMD ["apache2-foreground"]
