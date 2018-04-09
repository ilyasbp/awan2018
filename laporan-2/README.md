# Laporan 2

## Soal 1

1. Buatlah Vagrantfile sekaligus provisioning-nya untuk menyelesaikan kasus.

##### Isi Vagrantfile load-balancer :
    Vagrant.configure(2) do |config|
        config.vm.box = "ubuntu/trusty64"
        config.vm.network "private_network", ip: "192.168.0.2"
        config.vm.provider "virtualbox" do |vb|
            vb.memory = "256"
        end
        config.vm.provision "shell", path: "provision.sh"
    end

##### Isi file provision load-balancer :
    #!/usr/bin/env bash
    apt-get update
    apt-get install -y nginx

##### Isi Vagrantfile worker1 :
    Vagrant.configure(2) do |config|
        config.vm.box = "ubuntu/trusty64"
        config.vm.network "forwarded_port", guest: 80, host: 8080
        config.vm.network "private_network", ip: "192.168.0.3"
        config.vm.provider "virtualbox" do |vb|
            vb.memory = "256"
        end
        config.vm.provision "shell", path: "provision.sh"
    end

##### Isi file provision worker1 :
    #!/usr/bin/env bash
    apt-get update
    apt-get install -y apache2
    apt-get update
    apt-get install -y php5 php5-fpm php5-cgi libapache2-mod-php5

##### Isi Vagrantfile worker2 :
    Vagrant.configure(2) do |config|
        config.vm.box = "ubuntu/trusty64"
        config.vm.network "private_network", ip: "192.168.0.4"
        config.vm.provider "virtualbox" do |vb|
            vb.memory = "256"
        end
        config.vm.provision "shell", path: "provision.sh"
    end

##### Isi file provision worker2 :
    #!/usr/bin/env bash
    apt-get update
    apt-get install -y apache2
    apt-get update
    apt-get install -y php5 php5-fpm php5-cgi libapache2-mod-php5

##### Isi file /etc/nginx/sites-available/default loadbalancer algoritma round-robin(default):
    upstream worker{
        server 192.168.0.3:80;
        server 192.168.0.4:80;
    }

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.php index.html index.htm;

        server_name localhost;

        location / {
                try_files $uri $uri/ =404;
                proxy_pass http://worker;
        }
}

##### Isi file /etc/nginx/sites-available/default loadbalancer algoritma least-connected:
    upstream worker{
        least_conn;
        server 192.168.0.3:80;
        server 192.168.0.4:80;
    }

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.php index.html index.htm;

        server_name localhost;

        location / {
                try_files $uri $uri/ =404;
                proxy_pass http://worker;
        }
}

##### Isi file /etc/nginx/sites-available/default loadbalancer algoritma ip-hash:
    upstream worker{
        ip_hash;
        server 192.168.0.3:80;
        server 192.168.0.4:80;
    }

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.php index.html index.htm;

        server_name localhost;

        location / {
                try_files $uri $uri/ =404;
                proxy_pass http://worker;
        }
}

### Langkah-langkah


## Soal 2

2. Analisa apa perbedaan antara ketiga algoritma tersebut.

-Load balancing dengan algoritma round robin memiliki sistem yang berganti gantian. Maksud berganti gantian itu adalah load balancer misalkan memiliki 3 worker, sebut saja worker 1, worker 2, dan worker 3. Maka ketika ada request akan ditangani worker 1, apabila ada request lagi maka ditangani worker 2, begitu seterusnya dilakukan secara bergantian.

-Least-connected adalah algoritma dengan sistem yang dilihat dari banyaknya request aktif yang ditangani oleh suatu worker. Misalkan ada 3 worker. Sebut saja worker 1, worker 2 dan worker 3.
    Worker 1 menangani 7 request aktif
    Worker 2 menangani 10 request aktif
    Worker 3 tidak menangani request aktif.
Maka ketika ada request aktif akan ditangani oleh worker 3.  Akan terus ditangani hingga jumlah request aktif sama dengan jumlah request aktif paling sedikit yang ditangani suatu worker. Untuk hal ini maka worker 3 akan disamakan jumlah request aktifnya dengan worker 1. Setelah jumlah request aktif sama maka akan menggunakan algoritma round robin.
ip-hash = 1 ip ditangani 1 worker yang tetap.

-IP-hash adalah algoritma dengan sistem dimana setiap satu IP ditangani oleh satu worker yang tetap.


## Soal 3

3. Biasanya pada saat membuat website, data user yang sedang login disimpan pada session. Session secara default tersimpan pada memory pada sebuah host. Bagaimana cara mengatasi masalah session ketika kita melakukan load balancing?

Dengan menggunkan IP hash. Jadi satu IP ditangani oleh worker yang sama.
