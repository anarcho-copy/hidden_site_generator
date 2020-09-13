#!/bin/bash

count=$(sqlite3 books.db "SELECT COUNT(*) FROM books;");

for i in `seq 1 $count`;
do
    id=`cat /proc/sys/kernel/random/uuid`
    sqlite3 books.db "UPDATE books SET id='$id' WHERE rowid='$i';"
    echo "$i  >  $id"
done
#uuidgen look this
sqlite3 books.db "SELECT id,title FROM books;";
