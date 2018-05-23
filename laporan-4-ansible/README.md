# Laporan 4 Ansible

## Tools

Ansible adalah sebuah perangkat lunak komputer (software) yang bisa membantu seorang sistem administrator atau devops untuk melakukan otomasi di servernya. Dengan Ansible, mereka dapat melakukan instalasi, deployment, bahkan mengupdate server. Ansible mampu terkoneksi dengan server semacam LDAP dan Kerberos, lalu mengatur semua hal yang ada di dalamnya. Sistem kerja ansible biasanya tidak membutuhkan agen khusus melainkan hanya dengan koneksi SSH.

Ansible berjalan pada koneksi SSH remote ke client yang ingin di deploy atau dilakukan otomasi. Ansible pula membutuhkan data server tujuan (inventory). Pada langkah berikutnya, ansible memegang peranan aktif menjadi playbook dan roles. Konfigurasi dapat ditulis dengan format mark up YAML karena sangat mudah dibaca oleh manusia. Sedangkan untuk environment variabel dapat ditulis pada format JSON. Sehingga ansible dapat menjadi dokumentasi tersendiri nantinya. Ansible dapat digunakan pada Linux dan Ubuntu.

## Persoalan

1. Buat 3 VM, 2 Ubuntu 16.04 sebagai worker, 1 Debian 9 sebagai DB server
2. Pada vm Debian install Mysql dan setup agar koneksi DB bisa diremote dan memiliki user:
    username: regal
    password: bolaubi

3. Pada worker:
    2.1. Install Nginx
    2,2, Install PHP 7.2
    2.3. Install composer
    2.4. Install Git
	dan pastikan worker dapat menjalankan Laravel 5.6
    
4. Clone [https://github.com/udinIMM/Hackathon](https://github.com/udinIMM/Hackathon) pada setiap worker dan setup database pada .env mengarah ke DB server.

5. Setup root directory nginx ke folder Laravel hasil clone repo diatas

## Solusi

### Soal 1
Membuat 3 VM, 2 Ubuntu 16.04 sebagai worker, 1 Debian 9 sebagai DB server

lalu buat file hosts yang berisi
[worker] :
	
	worker1 ansible_host=192.168.100.49 ansible_ssh_user=cloud ansible_become_pass=raincloud
	worker2 ansible_host=192.168.100.48 ansible_ssh_user=cloud ansible_become_pass=raincloud
[server] :
	
	server1 ansible_host=192.168.100.89 ansible_ssh_user=cloud ansible_become_pass=raincloud


### Soal 2. Pada vm Debian install Mysql dan setup agar koneksi DB bisa diremote dan memiliki user:
username: regal
password: bolaubi

install sudo dulu karena debian belum ada sudo
	install sudo
	su
	apt-get install sudo

mengubah user cloud menjadi admin
	su
	usermod -aG sudo, adm cloud

jalankan perintah
ansible-playbook -i hosts debian.yml -k

penjelasan debian.yml

cara install mysql
- hosts: server
  become: yes
  tasks:
    - name: install mysql server
      apt: name={{ item }} state=latest update_cache=true
      with_items:
        - mysql-server

jalankan mysql
- hosts: server
  become: yes
  tasks:
	- name: start mysql server service
	      service: name=mysqld state=started enabled=yes

untuk membuat user dan database diperlukan phyton-mysql dan g++
- name: install required python MySQLdb lib to create databases and users
      apt: name={{item}} state=present
      with_items:
        - g++
        - python-mysqldb

membuat user dan database
- name: create database user
      mysql_user: name=regal password=bolaubi priv='*.*:ALL' host='%' state=present
 
    - name: create mysql database
      mysql_db: name=regal state=present

bind agar bisa diakses / diremote
- name: bind mysql remote address
      ini_file: dest=/etc/mysql/mariadb.conf.d/51-bind.cnf
                section=mysqld
                option=bind-address
                value={{item}}
      with_items: 0.0.0.0

lalu restart mysql
- name: restart mysql
service: name=mysqld state=restarted

#soal 3 4 dan 5

Jalankan perintah:
		
	ansible-playbook -i hosts worker.yml -k

penjelasan worker.yml

install dependencies for apt
- untuk menginstall dependencies agar bisa menambah repositori pada apt

add php7 repository
- untuk menambah repositori php 7

Install php
- untuk menginstall php

Install nginx
- untuk menginstall nginx

- copy config nginx
untuk mengopy config nginx pada folder ansible-playbook ke config nginx di vm

- restart service nginx
restart nginx

- download composer,install composer,dll
menginstall composer

- Install git
install git

- clone and deploy laravel project
clone dan deploy proyek laravel

#hasil

kasih gambar ss.png

## Kendala
###### tidak bisa ssh? install openssh-server di vm
	sudo apt-get install openssh-server
###### network error?
	set network virtual box menjadi "bridge"
###### error phyton? install phyton di vmnya
	sudo apt-get install python-yaml python-jinja2 python-paramiko python-crypto


## Kesimpulan

1. Ansible dapat menangani server menjadi lebih otomatis dan simpel
2. Ansible dapat mengubah proses infrastructure management atau manajemen infrastruktur dari suatu program dari manual menjadi otomatis
3. Ansible juga dapat digunakan untuk mengubah proses deployment atau penempatan dari manual ke otomatis. 
4. Ansible berfungsi untuk mengubah membuat configuration management atau menejemen konfigurasi dari suatu program dari manual menjadi otomatis.


## Sumber
- https://github.com/leucos/ansible-tuto
- https://medium.com/@asked_io/how-to-install-php-7-2-x-nginx-1-10-x-laravel-5-6-f9e30ee30eff
- https://github.com/Vinelab/ansible-composer/blob/master/tasks/main.yml
