# Laporan 1

## Soal Nomor 1
1. Buat vagrant virtual box dan buat user ‘awan’ dengan password ‘buayakecil’.

### Langkah-langkah :

	1. Ketik Vagrant ssh
	2. Ketik useradd awan
	3. Ketik passwd awan
	4. Masukkan password 'buayakecil'
	5. Untuk mengecek user sudah ditambahkan atau belum dengan cara cat /etc/passwd/
	6. Untuk login dengan cara mengetik sudo login lalu masukkan password

##### Error
![](/laporan-1-vagrant/images/1-error.png)


##### Cara buat

![](/laporan-1-vagrant/images/1-cara-buat.png)

##### Cara cek

![](/laporan-1-vagrant/images/1-cara-cek.png)


##### Berhasil

![](/laporan-1-vagrant/images/1-berhasil.png)

##### Error login harus pake sudo

![](/laporan-1-vagrant/images/1-error-login-harus-pake-sudo.png)

##### Login

![](/laporan-1-vagrant/images/1-login.png)

##### Error logout

![](/laporan-1-vagrant/images/1-error-logout.png)

##### Logout

![](/laporan-1-vagrant/images/1-logout.png)

## Soal Nomor 2
2. Buat vagrant virtualbox dan lakukan provisioning install Phoenix Web Framework

##### Berikut isi dari Vagrantfile :
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb <br>
	apt-get update <br>
	apt-get install -y esl-erlang <br>
	apt-get install -y elixir <br>
	
##### Vagrantfie yang sudah terisi perintah provisioning

![](/laporan-1-vagrant/images/2-file-provision.png)

##### Untuk mengecek berhasil tidaknya instalasi Phoenix Web Framework maka perintah yang digunakan yaitu :
    elixir –v

##### Apabila berhasil maka akan muncul seperti ini

![](/laporan-1-vagrant/images/2-install-phoenix.png)

## Soal Nomor 3
3. Buat vagrant virtualbox dan lakukan provisioning install:
* php
* mysql
* composer
* nginx

Setelah melakukan provioning, clone https://github.com/fathoniadi/pelatihan-laravel.git pada folder yang sama dengan vagrantfile di komputer host. Setelah itu sinkronisasi folder pelatihan-laravel host ke vagrant ke /var/www/web dan jangan lupa install vendor laravel agar dapat dijalankan. Setelah itu setting root document nginx ke /var/www/web. webserver VM harus dapat diakses pada port 8080 komputer host dan mysql pada vm dapat diakses pada port 6969 komputer host

##### Isi provision file :
	#install mysql <br>
	debconf-set-selections <<< 'mysql-server mysql-server/root_password password 12345678' <br>
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 12345678' <br>
	apt-get update <br>
	apt-get install -y mysql-server <br>

	#install php <br>
	#php 5 <br>
	apt-get update <br>
	apt-get install php5 curl -y <br>

	#php 7 <br>
	#apt-get update <br>
	#apt-get install -y python-software-properties software-properties-common <br>
	#LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y <br>
	#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise main restricted universe multiverse" -y <br>
	#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-updates main restricted universe multiverse" -y <br>
	#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-security main restricted universe multiverse" -y <br>
	#add-apt-repository "deb http://kambing.ui.ac.id/ubuntu/ precise-backports main restricted universe multiverse" <br>
	#apt-get update <br>
	#apt-get install -y php7.1 curl <br>

	#install composer <br>
	apt-get update <br>
	curl -sS https://getcomposer.org/installer | php <br>
	sudo mv composer.phar /usr/local/bin/composer <br>

	#install nginx <br>
	apt-get update <br>
	apt-get install -y nginx <br>

##### Cara mengecek instalasi mysql berhasil atau tidak menggunakan :
    mysql -V

![](/laporan-1-vagrant/images/3-install-mysql.png)

##### Cara mengecek instalasi php berhasil atau tidak menggunakan :
	php –v

![](/laporan-1-vagrant/images/3-install-php.png)


##### Cara mengecek instalasi composer berhasil atau tidak menggunakan :
	composer -v

![](/laporan-1-vagrant/images/3-install-composer.png)

##### Cara mengecek instalasi nginx berhasil atau tidak menggunakan :
	nginx -v

![](/laporan-1-vagrant/images/3-install-nginx.png)


### Kendala:
* install laravel yang membutuhkan php 7 <br>
* install php7 di ubuntu 12. kesulitan mencari repository yang menyediakan php 7 untuk ubuntu 12. Sehingga tidak bisa mengerjakan yang setelahnya


## Soal Nomor 4 
4. Buat vagrant virtualbox dan lakukan provisioning install:
* Squid proxy <br>
* Bind9 <br>
	
##### Isi file bootstrap.sh
![](/laporan-1-vagrant/images/4-file-provision.png)

##### Cara mengecek instalasi squid beserta versinya :
![](/laporan-1-vagrant/images/4-squid.png)

##### Cara mengecek instalasi bind9 beserta versinya :
![](/laporan-1-vagrant/images/4-bind9.png)

## Kesimpulan :
Virtual Machine kegunaannya mengurangi biaya, terkadang alat atau mesin tidak ada jadi digunakanlah virtual machine. Serta bisa untuk simulasi.
Dengan provisioning kita bisa mengisi virtual machine atau VM dengan cepat. Apalagi vm yang dibutuhkan banyak. Karena secara default vm itu kosongan.
