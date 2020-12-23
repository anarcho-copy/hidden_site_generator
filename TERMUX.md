# Anarcho-Copy HTML generatörü / Tor-Onion Servisi - Android (root gerektirmez)

Not: Bu generator android işletim sisteminde termux üzerinde test edilmiştir. Kuruluma geçmek için yönergeleri takip edin.

## Gerekli ortamın hazırlanması (android)

İlk önce `termux` programını android cihazına kur, tüm kurulumlar termux ortamında yapılıcaktır.

 - [Termux - Play Store](https://play.google.com/store/apps/details?id=com.termux)
 - [Termux - F-Droid](https://f-droid.org/en/packages/com.termux/)


Daha rahat yazabilmek için [hacker's keyboard](https://play.google.com/store/apps/details?id=org.pocketworkstation.pckeyboard) klavye uygulamasını kullanın.

## Kurulum

Termux terminaline gir ardından gerekli paketleri ve programları kur:

```bash
$ pkg update && pkg install wget git tor ghostscript imagemagick exiftool sqlite nginx poppler bc
```

Şimdi kuruluma başlayabilirsin, adımları teker teker uygulan gerekiyor.

Projenin kaynak kodunu gerekli dizine indir:

```bash
$ mkdir -p $PREFIX/var/www/hidden-service/
$ chown -R $USER:$USER $PREFIX/var/www/hidden-service/
$ cd $PREFIX/var/www/hidden-service/
$ git clone https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator.git
```


PDF dosyalarını indirip gerekli dizinleri ayarla.
Telefonunun internet hızına göre bu adım biraz uzun sürecek, çay içip bekle.

```bash
$ mkdir -p $PREFIX/var/www/public/anarcho-copy.org/free/
$ chown -R $USER:$USER $PREFIX/var/www/public/anarcho-copy.org/free/
$ cd $PREFIX/var/www/public/anarcho-copy.org/free/
$ wget https://anarcho-copy.org/.list
$ for i in `<.list`; do wget "https://anarcho-copy.org/free/$i"; done
$ rm .list
```

ardından generatorun kaynak konundaki config dosyasına termux için pdf yolunu tanıtman gerekir, bunun için   **nano** ile `$PREFIX/var/www/hidden-service/hidden_site_generator/bin/config.sh` dosyasını aç, `CTRL+W` yapıp `pdf_dir` değişkenini bul. Sonrasında ise o satırı aşağıdaki satır ile değiştir:

```bash
pdf_dir="/data/data/com.termux/files/usr/var/www/public/anarcho-copy.org/free"
```
bu kadar.


## NGINX

Moduler şekilde konfigure etmek için `$PREFIX/etc/nginx/nginx.conf` dosyasında `http` bloğunun içine aşağıdaki satırı ekle:

```
include /data/data/com.termux/files/usr/etc/nginx/conf.d/*.conf;
```

ardından moduler dizini oluştur:

```
$ mkdir -p $PREFIX/etc/nginx/conf.d/
```

proje dizinindeki nginx konfigurasyon dosyasını oluşturduğun dizine kopyala ve nginx'i çalıştır.
```bash
$ cp $PREFIX/var/www/hidden-service/hidden_site_generator/termux_nginx.conf $PREFIX/etc/nginx/conf.d/
$ nginx
```


## TOR

Tor onion servisinin anahtar dosyalarının saklanması için gerekli dizini oluştur:

```bash
$ mkdir -p $PREFIX/var/lib/tor/
```

ardından `$PREFIX/etc/tor/torrc` dosyasına aşağıdaki satırları ekle:

```
 HiddenServiceDir /data/data/com.termux/files/usr/var/lib/tor/hidden_service/
 HiddenServicePort 80 127.0.0.1:8090
```

son olarak tor servisini çalıştır:

```bash
$ nohup tor > $PREFIX/var/log/tor.log &
```

Oluşturulan **onion** adresini görmek için ise: 

```bash
$ cat $PREFIX/var/lib/tor/hidden_service/hostname 
```

Onion adresini generatore tanıtmak için aşağıdaki komutu çalıştır (web adresini sayfa üzerinde göstermek için):

```bash
$ mkdir -p $PREFIX/var/www/hidden-service/hidden_site_generator/web && ln -s $PREFIX/var/lib/tor/hidden_service/hostname $PREFIX/var/www/hidden-service/hidden_site_generator/web/
```

> Not: Bu rehberde termux sistem servislerine değinilmedi, istersen [uygulayabilirsin](https://github.com/termux/termux-services).
>
> Unutma: Eğer tor düğümleri sansürlenen bir coğrafyadaysan obfs4 köprü ayarlarını elle yapman gerekecektir.


## Statik Dosyaları Oluştur

Proje dizinine git ve statik dosyaları aşağıdaki argümanlar ile yarat:

```bash
$  cd $PREFIX/var/www/hidden-service/hidden_site_generator/
$ ./termux_run.sh -bcg
```

## Kullanım

```
usage: ./termux_run.sh [-h] [-b|-c] [-g] [-t] | [ -p --delete | --delete-all ]
-h       help page
-b       build html.
-c       create static contents (as image etc.)
-g       generate the web site as use created files
-t       view tor adress
-p
   --delete     (it does not include the static contents)
   --delete-all (purge all files, it does include the static contents)
```


## Proje Dizinleri

```text
bin/                      :  generatörü inşa eden temel dosyalar.
src/                      :  kullanılan ek kaynaklar
var/                      :  veri tabanı (sqlite3)
i/template                :  html şablonları
i/contents                :  manual dosyaların bulunduğu dizin

i/contents/css/primer.css :  Github Primer css teması. (henüz uygulanıyor)
```

### Demo sürüm:

https://build.anarcho-copy.org
