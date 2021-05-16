cd /var/www

wget https://nodejs.org/dist/v15.3.0/node-v15.3.0-linux-x64.tar.xz
tar xf  node-v15.3.0-linux-x64.tar.xz
cd node-v15.3.0-linux-x64

ln -s /usr/local/bin/npm /var/www/node-v15.3.0-linux-x64/bin/npm
ln -s /usr/local/bin/node /var/www/node-v15.3.0-linux-x64/bin/node