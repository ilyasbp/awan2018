# Laporan 3 Docker

## Tools

## Persoalan
Nana adalah mahasiswa semester 6 dan sekarang sedang mengambil matakuliah komputasi awan. Saat mengambil matakuliah komputasi awan dia mendapatkan materi sesilab tentang Docker. Suatu hari Nana ingin membuat sistem reservasi lab menggunakan Python Flask. Dia dibantu temannya, Putra awalnya membuat web terlebih dahulu. Web dapat di download [disini](https://cloud.fathoniadi.my.id/reservasi.zip).

Setelah membuat web, Putra dan Nana membuat Custom Image Container menggunakan Dockerfile. Mereka membuat image container menggunakan base container ubuntu:16.04 kemudian menginstall aplikasi flask dan pendukungnya agar website dapat berjalan [1].

Setelah membuat custom image container, mereka kemudian membuat file __docker-compose.yml__. Dari custom image yang dibuat sebelumnya mereka membuat 3 node yaitu worker1, worker2, dan worker3 [2].

Setelah mempersiapkan worker, mereka kemudian menyiapkan nginx untuk loadbalancing ketiga worker tersebut (diperbolehkan menggunakan images container yang sudah jadi dan ada di Docker Hub) [3].

Karena web mereka membutuhkan mysql sebagai database, terakhir mereka membuat container mysql (diperbolehkan menggunakan images container yang sudah jadi dan ada di Docker Hub)  yang dapat diakses oleh ke-3 worker yang berisi web mereka tadi dengan environment:

    username : userawan
    password : buayakecil
    nama database : reservasi

Selain setup environmet mysql, mereka juga mengimport dump database web mereka menggunakan Docker Compose dan tak lupa membuat volume agar storage mysql menjadi persisten[4].

## Solusi

#### Membuat image dengan Ubuntu 16.04 dan aplikasi flask dan pendukungnya

#### Membuat docker composer uantuk membuat container worker 1, worker 2, dan worker 3 menggunakan image yang telah dibuat

docker-compose build
docker-compose scale worker=3
docker-compose up -d

#### Membuat container load-balancer dengan nginx

#### Membuat container mysql dan menghubungkannya ke 3 worker

#### Mengimport dump database web menggunakan docker compose dan membuat volume agar stroage mysql menjadi persistent

## Kendala

error:
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-x5425M/MySQL-python/
solusi:
dengan menambahkan apt-get install -y libmysqlclient-dev pada Dockerfile

## Kesimpulan

## Sumber
flask:
http://containertutorials.com/docker-compose/flask-simple-app.html
load balance:
https://www.sep.com/sep-blog/2017/02/28/load-balancing-with-nginx-and-docker/
https://auth0.com/blog/load-balancing-nodejs-applications-with-nginx-and-docker/
https://docs.docker.com/samples/library/nginx/#running-nginx-in-debug-mode
install requirement python:
https://stackoverflow.com/questions/34398632/docker-how-to-run-pip-requirements-txt-only-if-there-was-a-change
import dump mysql: https://stackoverflow.com/questions/43880026/import-data-sql-mysql-docker-container