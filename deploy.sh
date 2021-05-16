#!/bin/bash

git config --global http.sslVerify false

#使用镜像地址，腾讯云clone代码否则会很慢
git_repository=https://github.com.cnpmjs.org/antOnHisWay/long-march.git

web_dir=/var/www
symlink_name=long-march

dir_tag=`date "+long-march-%y.%m.%d" `
laravel_dir_tag=$dir_tag"/laravel"
coreui_dir_tag=$dir_tag"/coreui"


if [ ! -w "$web_dir" ]; then
  echo "Cannot write to $web_dir!"
  exit 3
fi

echo "Exporting archive to /var/www/$dir_tag"
cd /var/www
git clone "$git_repository" "$dir_tag" || {
  echo "Could not export git branch!"
  exit 2
}

ln -s /var/www/shared/storage $web_dir/$laravel_dir_tag/storage
ln -s /var/www/shared/bootstrap/cache $web_dir/$laravel_dir_tag/bootstrap/cache

rsync /var/www/vendor.tar.gz "$web_dir/$laravel_dir_tag/"
cd "$web_dir/$laravel_dir_tag/"
tar -zxvf "$web_dir/$laravel_dir_tag/vendor.tar.gz"

rsync /var/www/coreui_node_modules.tar.gz "$web_dir/$coreui_dir_tag/"
cd "$web_dir/$coreui_dir_tag/"
tar -zxvf "$web_dir/$coreui_dir_tag/coreui_node_modules.tar.gz"

rsync /var/www/laravel_node_modules.tar.gz "$web_dir/$laravel_dir_tag/"
cd "$web_dir/$laravel_dir_tag/"
tar -zxvf "$web_dir/$laravel_dir_tag/laravel_node_modules.tar.gz"

cp $web_dir/$laravel_dir_tag/.env.prod $web_dir/$laravel_dir_tag/.env

echo "Exported $git_branch branch to $web_dir/$dir_tag"

echo "Running NPM"

unlink "$web_dir/$symlink_name"
ln -s "$web_dir/$dir_tag" "$web_dir/$symlink_name"

docker exec -it longMarch chown www-data:www-data -R /var/www/shared
docker exec -it longMarch chown www-data:www-data -R /var/www/long-march

cd $web_dir/$laravel_dir_tag
/var/www/node-v15.3.0-linux-x64/bin/npm run dev

echo "Done!"