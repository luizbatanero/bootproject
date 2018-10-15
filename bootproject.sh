#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

slug=$1

if [ -d $slug ]; then
    echo "The directory already exists"
    exit 1
fi

git clone git@bitbucket.org:batanero/bootstrap.git $slug
cd $slug

rm -rf .git

cd laravel
composer install && composer run bootstrap

sed -i 's/DB_DATABASE=.*/DB_DATABASE='$slug'/' .env

sed -i "/sites:/a \    - map: $slug.teste\n\      to: /home/vagrant/Code/$slug/public" ~/.homestead/Homestead.yaml
sed -i "/databases:/a \    - $slug" ~/.homestead/Homestead.yaml

cd ~/Homestead && vagrant up && vagrant provision

echo "192.168.10.10   $slug.teste" >> /etc/hosts

google-chrome "http://$slug.teste"
