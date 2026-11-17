FROM php:8.2-apache
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN a2dismod mpm_event && a2enmod mpm_prefork rewrite
COPY . /var/www/html/
CMD sh -c "sed -i \"s/Listen 80/Listen ${PORT:-80}/\" /etc/apache2/ports.conf; sed -i \"s/:80>/:${PORT:-80}>/\" /etc/apache2/sites-available/000-default.conf; docker-php-entrypoint apache2-foreground"
