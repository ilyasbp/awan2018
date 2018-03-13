# Komputasi Awan 2018

Magista Bella Puspita   5114100007 <br>
Agung Rezki Ramadhan    5114100074 <br>
Ilyas Bintang Prayogi   5114100157 <br>


1. Buat vagrant virtual box dan buat user ‘awan’ dengan password ‘buayakecil’.

Langkah-langkah :

Error

Cara buat




Cara cek

Berhasil


error login harus pake sudo

login

erro logout

logout


 
2. Buat vagrant virtualbox dan lakukan provisioning install Phoenix Web Framework

Berikut isi dari Vagrantfile :

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
apt-get update
apt-get install -y esl-erlang
apt-get install -y elixir

Vagrantfie yang sudah terisi perintah provisioning

![](https://github.com/ilyasbp/awan2018/blob/master/images/2-file-provision.png?raw=true)

Untuk mengecek berhasil tidaknya instalasi Phoenix Web Framework maka perintah yang digunakan yaitu
									    											elixir –v

Apabila berhasil maka akan muncul seperti ini

3. Buat vagrant virtualbox dan lakukan provisioning install:
1.	php
2.	mysql
3.	composer
4.	nginx
setelah melakukan provioning, clone https://github.com/fathoniadi/pelatihan-laravel.git pada folder yang sama dengan vagrantfile di komputer host. Setelah itu sinkronisasi folder pelatihan-laravel host ke vagrant ke /var/www/web dan jangan lupa install vendor laravel agar dapat dijalankan. Setelah itu setting root document nginx ke /var/www/web. webserver VM harus dapat diakses pada port 8080 komputer host dan mysql pada vm dapat diakses pada port 6969 komputer host
Isi provision file
#install mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password 12345678'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 12345678'
apt-get update
apt-get install -y mysql-server

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
apt-get update
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#install nginx
apt-get update
apt-get install -y nginx

Cara mengecek instalasi mysql berhasil atau tidak menggunakan 

mysql -V

Cara mengecek instalasi mysql berhasil atau tidak menggunakan :

php –v



Cara mengecek instalasi composer berhasil atau tidak menggunakan :

composer -v

Cara mengecek instalasi nginx berhasil atau tidak menggunakan :

nginx -v



Kendala:
-install laravel yang membutuhkan php 7
-install php7 di ubuntu 12. kesulitan mencari repository yang menyediakan php 7 untuk ubuntu 12

sehingga tidak bisa mengerjakan yang setelahnya


 
4. Buat vagrant virtualbox dan lakukan provisioning install:
1.	Squid proxy
2.	Bind9
Isi file bootstrap.sh

Cara mengecek instalasi squid beserta versinya :


Cara mengecek instalasi bind9 beserta versinya :


