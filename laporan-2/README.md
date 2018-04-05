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

round-robin = genti-genten
least-connected = pilih yang gabut. misal, ada 10 user. worker1 menangani 4. worker2 menangani 6. kalau ada request lagi. dia ditangani worker1. karena lebih sedikit requestnya.
ip-hash = 1 ip ditangani 1 worker yang tetap.


## Soal 3

3. Biasanya pada saat membuat website, data user yang sedang login disimpan pada session. Sesision secara default tersimpan pada memory pada sebuah host. Bagaimana cara mengatasi masalah session ketika kita melakukan load balancing?

ngawur: dengan menggunakan ip hash