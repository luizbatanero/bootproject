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

laradock new $slug

google-chrome "http://$slug.teste"
