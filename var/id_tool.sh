#!/bin/bash
#perl-Digest-SHA perl-IO-Compress
#exiftool -m -DocumentID= *

cd "$(dirname "$0")";
. ../bin/config.sh #get pdf_dir

function guide() {
echo -e "usage: ./`basename $0` [generatedb] [listdb] [new <file>] \n  [set <uuid:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx> <file>]"
}

function generatedb() {
count=$(sqlite3 books.db "SELECT COUNT(*) FROM books;");
for i in `seq 1 $count`;
do
    echo "----------------------------------------------------------------"
    id=$(cat /proc/sys/kernel/random/uuid)
    sqlite3 books.db "UPDATE books SET id='uuid:$id' WHERE rowid='$i';"
    echo "$i  >  $id"
    url=$(sqlite3 books.db "SELECT url FROM books WHERE rowid='$i';")
    exiftool -m -DocumentID="uuid:$id" $pdf_dir/$url.pdf
    echo "$pdf_dir/$url.pdf"
    echo "----------------------------------------------------------------"
done
}

function listdb() {
#uuidgen look this
sqlite3 books.db "SELECT id,title FROM books;";
}

function new() {
id=$(cat /proc/sys/kernel/random/uuid);
exiftool -m -DocumentID="uuid:$id" $1 && exiftool $1 | grep 'Document ID';
echo "uuid:$id";
echo "$(date '+%d/%m/%Y %H:%M:%S')  <  $1";
}

function set() {
exiftool -m -DocumentID="$1" $2 && exiftool $2 | grep 'Document ID';
echo "$1 - $2"
}

if [ "$#" -lt 1 ]; then
    guide;
fi

$@;
