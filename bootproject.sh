#!/bin/bash

slug=$1

git clone git@bitbucket.org:batanero/bootstrap.git $slug
cd $slug

cd laravel
composer install && composer run bootstrap

sed -i "/sites:/a \    - map: $slug.dev\n\      to: /home/vagrant/Code/$slug/public" ~/.homestead/Homestead.yaml
sed -i "/databases:/a \    - $slug" ~/.homestead/Homestead.yaml

cd ~/Homestead && vagrant up && vagrant provision

google-chrome "http://$slug.dev"
