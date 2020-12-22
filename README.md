# Anarcho-Copy HTML generatörü / Tor-Onion Servisi.
 
 - Bu generator apt tabanlı debian ve dnf tabanlı fedora üzerinde test edilmiştir. Android işletim sistemiyle de uyumludur, android üzerinde kurulum için [TERMUX](TERMUX.md) belgesindeki yönergeleri takip edin. 
 - Fedora için container uyguluması olarak podman kullanıldı, scriptte komut olarak docker olarak geçmekte bu sebeple docker komutunu podmana manipüle etmek için podman-docker kurulucaktır, eğer fedora sisteminizde docker varsa `install_requirements.sh` dosyasındaki podman-docker argümanını kaldırın.

## İndir

```bash
$ sudo mkdir -p /var/www/hidden-service/
$ sudo chown -R $USER:$USER /var/www/hidden-service/
$ cd /var/www/hidden-service/
$ git clone https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator.git
```



## Basit Kullanım
```bash
$ ./run_server.sh 
usage: ./run_server.sh [-h] [-n] [-b|-c] [-g] [-r] [-t|-s] | [ -p --delete | --delete-all | --web ]
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
```bash
#for generate html and static files 
ghostscript
imagemagick
exiftool
sqlite3
nginx
coreutils #this is must already exist
poppler-utils

#for debian
docker  #for onion service, isn't necessary.
#for fedora
podman  #for onion service, isn't necessary.
podman-docker #for manipule docker command to podman.
```


## Çalıştırmadan Önce..

Gerekli pdf dosyalarını indirip dizinleri ayarla.
sunucunun internet hızına göre bu adım biraz uzun sürecek, çay içip bekle.

```bash
$ sudo mkdir -p /var/www/public/anarcho-copy.org/free/
$ sudo chown -R $USER:$USER /var/www/public/anarcho-copy.org/free/
$ cd /var/www/public/anarcho-copy.org/free/
$ wget https://anarcho-copy.org/.list
$ for i in `<.list`; do wget "https://anarcho-copy.org/free/$i"; done
$ rm .list
```

Ardından proje dizinine git ve;

önce gerekli programları indir,

```bash
#for debian
$ sudo ./install_requirements.sh debian

#for fedora
$ sudo ./install_requirements.sh rhel
```


sonra local nginx ayarlarını hallet,
```bash
#for debian
$ sudo cp main_nginx.conf /etc/nginx/sites-available/anarchocopyService
$ sudo ln -s /etc/nginx/sites-available/anarchocopyService /etc/nginx/sites-enabled/anarchocopyService
$ sudo service nginx restart

#for fedora
$ sudo cp main_nginx.conf /etc/nginx/conf.d/anarchocopyService.conf
$ sudo systemctl restart nginx.service
```


tor-nginx docker veya podman imajını inşa et,

```bash
#for debian
$ tar xzvf TorNginxDockerImage.tar.gz
$ cd TorNginxDockerImage/
$ docker build -t tor-docker .
$ cd ..

#for fedora
$ tar xzvf TorNginxDockerImage.tar.gz
$ cd TorNginxDockerImage/
$ podman --cgroup-manager=cgroupfs build -t tor-docker .
$ cd ..
```


yeni bir tor adresi yarat,

```bash
$ ./run_server.sh -n
```


statik dosyaları inşa et (bu adımdan sonra http://localhost:8080 kullanılabilir. makineni afişe etmemek için 8080 portunun dış dünyaya kapalı olduğundan emin ol),

```bash
$ ./run_server.sh -bcg
```


son olarak tor sunucusunu ayağa kaldır.

```bash
$ ./run_server.sh -r
```

Tor adresine bak ve ziyaret et. (tor+nginx docker sunucusu onion servisini http://localhost:8080 adresini dinleyerek servis etmektedir)
```bash
$ ./run_server.sh -t
copyxxxxxxxxxxxxx.onion
```

### Unutma

Eğer tor düğümleri sansürlenen bir coğrafyadaysan obfs4 köprü ayarlarını elle yapman gerekecektir.


## Proje Dizinleri

```bash
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
