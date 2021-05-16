#pre-requirement: create the ssl key/crt in this directory
#more info here in the doc: https://httpd.apache.org/docs/2.4/ssl/ssl_faq.html
#openssl req -new -x509 -nodes -out server.crt -keyout server.key

FROM php:7.4.16-apache

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN ln -s /etc/apache2/mods-available/rewrite.load  /etc/apache2/mods-enabled/rewrite.load

COPY ./long-march.asdn.top.pem /etc/ssl/certs/long-march.asdn.top.pem
COPY ./long-march.asdn.top.key /etc/ssl/private/long-march.asdn.top.key

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN rm -rf /var/www/html

COPY ./vendor.tar.gz /var/www/
COPY ./laravel_node_modules.tar.gz /var/www
COPY ./coreui_node_modules.tar.gz /var/www

RUN a2enmod ssl
RUN service apache2 restart