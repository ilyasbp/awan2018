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

### Error
![](/laporan-1/images/1-error.png)


Cara buat

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-cara-buat.png?raw=true)


Cara cek

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-cara-cek.png?raw=true)


Berhasil

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-berhasil.png?raw=true)

Error login harus pake sudo

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-error-login-harus-pake-sudo.png?raw=true)

Login

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-login.png?raw=true)

Error logout

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-error-logout.png?raw=true)

Logout

![](https://github.com/ilyasbp/awan2018/blob/master/images/1-logout.png?raw=true)

 
2. Buat vagrant virtualbox dan lakukan provisioning install Phoenix Web Framework

Berikut isi dari Vagrantfile :

	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb <br>
	apt-get update <br>
	apt-get install -y esl-erlang <br>
	apt-get install -y elixir <br>

Vagrantfie yang sudah terisi perintah provisioning

![](https://github.com/ilyasbp/awan2018/blob/master/images/2-file-provision.png?raw=true)

Untuk mengecek berhasil tidaknya instalasi Phoenix Web Framework maka perintah yang digunakan yaitu :

			elixir –v

Apabila berhasil maka akan muncul seperti ini

![](https://github.com/ilyasbp/awan2018/blob/master/images/2-install-phoenix.png?raw=true)

3. Buat vagrant virtualbox dan lakukan provisioning install:
* php
* mysql
* composer
* nginx

	Setelah melakukan provioning, clone https://github.com/fathoniadi/pelatihan-laravel.git pada folder yang sama dengan vagrantfile di komputer host. Setelah itu sinkronisasi folder pelatihan-laravel host ke vagrant ke /var/www/web dan jangan lupa install vendor laravel agar dapat dijalankan. Setelah itu setting root document nginx ke /var/www/web. webserver VM harus dapat diakses pada port 8080 komputer host dan mysql pada vm dapat diakses pada port 6969 komputer host

Isi provision file :

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

Cara mengecek instalasi mysql berhasil atau tidak menggunakan :

			mysql -V

![](https://github.com/ilyasbp/awan2018/blob/master/images/3-install-mysql.png?raw=true)

Cara mengecek instalasi php berhasil atau tidak menggunakan :

			php –v

![](https://github.com/ilyasbp/awan2018/blob/master/images/3-install-php.png?raw=true)


Cara mengecek instalasi composer berhasil atau tidak menggunakan :

			composer -v

![](https://github.com/ilyasbp/awan2018/blob/master/images/3-install-composer.png?raw=true)

Cara mengecek instalasi nginx berhasil atau tidak menggunakan :

			nginx -v

![](https://github.com/ilyasbp/awan2018/blob/master/images/3-install-nginx.png?raw=true)


Kendala: <br>
install laravel yang membutuhkan php 7 <br>
install php7 di ubuntu 12. kesulitan mencari repository yang menyediakan php 7 untuk ubuntu 12 <br>

sehingga tidak bisa mengerjakan yang setelahnya


 
4. Buat vagrant virtualbox dan lakukan provisioning install: <br>
	* Squid proxy <br>
	* Bind9 <br>
	
Isi file bootstrap.sh

![](https://github.com/ilyasbp/awan2018/blob/master/images/4-file-provision.png?raw=true)

Cara mengecek instalasi squid beserta versinya :

![](https://github.com/ilyasbp/awan2018/blob/master/images/4-squid.png?raw=true)

Cara mengecek instalasi bind9 beserta versinya :

![](https://github.com/ilyasbp/awan2018/blob/master/images/4-bind9.png?raw=true)

Kesimpulan :

Virtual Machine kegunaannya mengurangi biaya, terkadang alat atau mesin tidak ada jadi digunakanlah virtual machine. Serta bisa untuk simulasi.
Dengan provisioning kita bisa mengisi virtual machine atau VM dengan cepat. Apalagi vm yang dibutuhkan banyak. Karena secara default vm itu kosongan.
