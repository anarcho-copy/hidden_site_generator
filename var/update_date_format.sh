#!/bin/bash
#for exiftool compaitable.
#from date '+%d/%m/%Y %T'
#to date '+%Y:%m:%d %T'

count=$(sqlite3 books.db "SELECT COUNT(*) FROM books;");
for i in `seq 1 $count`;
do
    date=`sqlite3 books.db "SELECT date FROM books WHERE rowid='$i'"`;

    if [ -z "$date" ]
     then
       echo "$i is empty";
     else
       year=`echo "$date" | head -c 10 | awk -v FS=/ -v OFS=: '{print $3,$2,$1}'`;
       hour=`echo ${date: -8}`;
      _date=`echo "$year $hour"`;
       sqlite3 books.db "UPDATE books SET date='$_date' WHERE rowid='$i'";
       echo "$date  >  $_date       : $i";
    fi
done
