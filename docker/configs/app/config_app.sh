#!/bin/bash


cd /var/www/html/app-grupo1;

php composer.phar update -n
chmod -R 777 storage bootstrap/cache
