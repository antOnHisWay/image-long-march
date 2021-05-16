docker run -dit --name longMarch \
-p 443:443 \
-p 80:80 \
-v /var/www/long-march:/var/www/long-march \
-v /var/www/shared/storage:/var/www/shared/storage \
-v /var/www/shared/bootstrap/cache:/var/www/shared/bootstrap/cache \
-v /var/www/node-v15.3.0-linux-x64:/var/www/node-v15.3.0-linux-x64 \
php-apache-long-march:latest



docker network create --driver bridge --subnet 172.19.0.0/16 --gateway 172.19.0.1 long-march

docker network connect --ip 172.19.0.9 long-march longMarch