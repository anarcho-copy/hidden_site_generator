# HTML GENERATOR

## İndir

```
$ sudo mkdir -p /var/hidden-service/
$ sudo chown -R $USER:$USER /var/hidden-service/
$ cd /var/hidden-service/
$ git clone https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator.git
```



## Basit Kullanım
```
$ ./run_server.sh 
usage: ./run_server.sh [-h] [-n] [-b|-c] [-g] [-r] [-t|-s] | [ -p --default | --all | --web ]
-h       help page
-n       generate new tor address
-b       build html.
-c       create static contents (as image etc.)
-g       generate the web site as use created files
-r       run tor server/container
-t       view tor adress
-s       status
-p
   --delete     (it does not include the static contents)
   --delete-all (purge all files, it does include the static contents)
   --web        (delete web/ files)
```

## Gereksinimler
```
ghostscript
imagemagick
exiftool
sqlite3
nginx
coreutils
```


## Çalıştırmadan Önce..

Proje dizinine git ve;

gerekli programları indir,

```
$ ./Install_requirements.sh
```


local nginx ayarlarını hallet,
```
$ sudo cp main_nginx.conf /etc/nginx/sites-available/anarchocopyService
$ sudo ln -s /etc/nginx/sites-available/anarchocopyService /etc/nginx/sites-enabled/anarchocopyService
$ sudo service nginx restart
```


tor-nginx docker imajını inşa et,

```
$ cd TorNginxDockerImage/
$ docker build -t tor-docker .
$ cd ..
```


yeni bir tor adresi yarat,

```
$ ./run_server.sh -n
```


statik dosyaları inşa et (bu adımdan sonra http://localhost:8080 kullanılabilir),

```
$ ./run_server.sh -bcg
```


son olarak tor sunucusunu ayağa kaldır.

```
$ ./run_server.sh -r
```

Tor adresine bak ve ziyaret et. (tor+nginx docker sunucusu onion servisini http://localhost:8080 adresini dinleyerek servis etmektedir)
```
$ ./run_server.sh -t
copyxxxxxxxxxxxxx.onion
```

### Unutma

Eğer tor düğümleri sansürlenen bir coğrafyadaysan obfs4 köprü ayarlarını elle yapman gerekecektir.


## Proje Dizinleri

```
bin/                 : generatörü inşa eden temel dosyalar.
src/                 : kullanılan ek kaynaklar
var/                 : veri tabanı (sqlite3)
i/template           : html şablonları
i/contents           : manual dosyaların bulunduğu dizin
TorNginxDockerImage/ : docker imajı

i/contents/css/primer.css : Github Primer css teması. (henüz uygulanıyor)
```

### Demo sürüm:

https://build.anarcho-copy.org