# HTML GENERATOR
## Basit Kullanım
```
$ ./run_server.sh 
usage: ./run_server.sh [-b|-c] [r]
-b       build html.
-c       create static contents (as image etc.)
-r       run server
```

## Gereksinimler
```
ghostscript
imagemagick
exiftool
sqlite3
md5sum 
python3
```

## Proje Dizinleri

```
bin/        : generatörü inşa eden temek dosyalar.
src/        : kullanılan ek kaynaklar
var/        : veri tabanı (sqlite3)
i/template  : html şablonları
i/contents  : manual dosyaların bulunduğu dizin

i/contents/css/primer.css : Github Primer css teması. (henüz uygulanıyor)
```
