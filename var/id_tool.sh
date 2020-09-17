#!/bin/bash
#perl-Digest-SHA perl-IO-Compress
#exiftool -m -DocumentID= *

function guide() {
echo "usage: ./`basename $0` [generate | list]"
}

function generate() {
count=$(sqlite3 books.db "SELECT COUNT(*) FROM books;");
for i in `seq 1 $count`;
do
    echo "----------------------------------------------------------------"
    id=$(cat /proc/sys/kernel/random/uuid)
    sqlite3 books.db "UPDATE books SET id='uuid:$id' WHERE rowid='$i';"
    echo "$i  >  $id"
    url=$(sqlite3 books.db "SELECT url FROM books WHERE rowid='$i';")
    exiftool -DocumentID="uuid:$id" /var/www/public/anarcho-copy.org/free/$url.pdf
    echo "/var/www/public/anarcho-copy.org/free/$url.pdf"
    echo "----------------------------------------------------------------"
done
}

function list() {
#uuidgen look this
sqlite3 books.db "SELECT id,title FROM books;";
}

if [ "$#" -lt 1 ]; then
    guide;
fi

$1;
