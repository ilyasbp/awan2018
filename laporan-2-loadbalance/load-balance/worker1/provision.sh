#!/usr/bin/env bash
apt-get update
apt-get install -y apache2
apt-get update
apt-get install -y php5 php5-fpm php5-cgi libapache2-mod-php5
