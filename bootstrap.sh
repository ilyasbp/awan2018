#!/usr/bin/env bash
#apt-get update
#apt-get install -y apache2

#no2
#wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
#apt-get update
#apt-get install -y esl-erlang
#apt-get install -y elixir

#no3
#install mysql
#debconf-set-selections <<< 'mysql-server mysql-server/root_password password 12345678'
#debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 12345678'
#apt-get update
#apt-get install -y mysql-server

#install php
#php 5
apt-get update
apt-get install php5 curl -y
#php 7
#apt-get update
#apt-get install -y python-software-properties software-properties-common
#LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise main restricted universe multiverse" -y
#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-updates main restricted universe multiverse" -y
#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-security main restricted universe multiverse" -y
#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-backports main restricted universe multiverse"
#apt-get update
#apt-get install -y php7.1 curl

#install composer
#apt-get update
#curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer
#apt-get update
#apt-get install -y nginx

#no4
#apt-get install -y squid
#apt-get install -y bind9 bind9utils bind9-doc
