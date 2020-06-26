#!/bin/bash

count=$(sqlite3 books.db "SELECT COUNT(*) FROM books;");

for i in `seq 1 $count`;
do
    id=`cat /dev/urandom | tr -dc 'a-e0-9' | fold -w 8 | head -n 1`
    sqlite3 books.db "UPDATE books SET id='$id' WHERE rowid='$i';"
    echo "$i  >  $id"
done

sqlite3 books.db "SELECT id,title FROM books;";
