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

##### Isi Dockerfile
    FROM ubuntu:16.04
    RUN apt-get update -y
    RUN apt-get install -y python python-pip python-dev build-essential libmysqlclient-dev
    RUN pip install --upgrade pip
    COPY ./reservasi /app
    WORKDIR /app
    RUN pip install -r req.txt
    ENTRYPOINT ["python"]
    CMD ["server.py"]
FROM ubuntu:16.04 -> dibuat berdasarkan image ubuntu 16.04
RUN apt-get install -y python python-pip python-dev build-essential libmysqlclient-dev -> menginstall tools phyton dll
RUN pip install --upgrade pip -> mengupgrade versi dari pip
COPY ./reservasi /app -> mengkopi folder web reservasi ke folder app di docker
WORKDIR /app : pindah ke folder app di docker
RUN pip install -r req.txt -> menginstall tools flask dll yang ada di file req.txt
ENTRYPOINT ["python"] -> menjalankan python
CMD ["server.py"] -> menjalankan command server.py dengan python

##### worker lalu di dijalankan dengan docker-compose.yml dengan config berikut ini :
    worker:
        build:
            context: ./
        depends_on:
            - db
        environment:
            DB_HOST: db
            DB_NAME: reservasi
            DB_USERNAME: userawan
            DB_PASSWORD: buayakecil
depends_on: db -> untuk menghubungkan worker dengan database
environment ... -> untuk mengatur environment yang dibutuhkan

#### Membuat container load-balancer dengan nginx

##### config nginx load-balance di docker-compose.yml :
    load-balance:
        depends_on:
            - worker
        image: nginx
        ports:
            - "9000:80"
        restart: always
        volumes:
            - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro

volumes: ./nginx.conf:/etc/nginx/conf.d/default.conf:ro gunanya untuk menghubungkan config nginx load balance di folder sekarang dengan folder nginx di docker

##### isi file nginx.conf
    server {
        listen 80 default_server;

        location / {
                proxy_pass http://worker;
        }
    }

karena tidak tahu ip dari worker2nya, maka upstream  tidak ditulis


#### Membuat container mysql dan menghubungkannya ke 3 worker dan mengimport dump database web menggunakan docker compose dan membuat volume agar strorage mysql menjadi persistent

##### config mysql di docker-compose.yml
    db:
        image: mysql:5.7
        volumes:
            - dbdata:/var/lib/mysql
            - ./reservasi/reservasi.sql:/docker-entrypoint-initdb.d/dump.sql
        restart: always
        environment:
            MYSQL_ROOT_PASSWORD: buayakecil
            MYSQL_DATABASE: reservasi
            MYSQL_USER: userawan
            MYSQL_PASSWORD: buayakecil

##### agar volume menjadi persisten maka ditambahkan seperti diatas pada docker-compose.yml
    volumes:
        dbdata:

#### Membuat docker composer uantuk membuat container worker 1, worker 2, dan worker 3 menggunakan image yang telah dibuat
worker-worker dapat dibuat dengan cara fasilitas di docker menggunakan scale

    docker-compose up --scale worker=3 --build

#### Tampilan debug load-balancer
![](/laporan-3-docker/images/debug-load-balance.png)

#### Tampilan dibrowser
![](/laporan-3-docker/images/tampilan-web-reservasi.png)

## Kendala

error:
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-x5425M/MySQL-python/
solusi:
dengan menambahkan apt-get install -y libmysqlclient-dev pada Dockerfile

error saat pip install req.txt. Ternyata harus diupdate pipnya menjadi versi 10

tidak tahu ip dari worker2nya. Tidak ditulis ternyata bisa

## Kesimpulan

## Sumber
install flask dll:
http://containertutorials.com/docker-compose/flask-simple-app.html
scale:
https://www.sep.com/sep-blog/2017/02/28/load-balancing-with-nginx-and-docker/
menghubungkan config loadbalancer di docker
https://docs.docker.com/samples/library/nginx/#running-nginx-in-debug-mode
install requirement python:
https://stackoverflow.com/questions/34398632/docker-how-to-run-pip-requirements-txt-only-if-there-was-a-change
import dump mysql:
https://stackoverflow.com/questions/43880026/import-data-sql-mysql-docker-container
config load-balance nginx.conf:
https://github.com/ofstudio/docker-compose-scale-example/blob/master/nginx.conf