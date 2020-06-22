#!/bin/bash
#printer friendly

#config
link="https://anarcho-copy.org"

cd "$(dirname "$0")"
cd ../bin/;
. config.sh; #import
cd - &> /dev/null
db_file="../var/books.db";

index_chars="1 A B C Ç D E F G Ğ I İ J K L M N O Ö P R S Ş T U Ü V W Y Z";


function author_table() {
sqlite3 $db_file "SELECT title,url FROM books WHERE author IS '$1'" > /tmp/.table.txt
while IFS="|" read -r title url
do
cat <<EOT
<li><a href="$link/copy/$url/">$title</a></li>
EOT
done < /tmp/.table.txt
}


function start_index() {
sqlite3 $db_file "SELECT author FROM books WHERE author LIKE '$1%'" > /tmp/.list.txt
sort /tmp/.list.txt | uniq -ci > /tmp/.listed.txt
while IFS=" " read -r count author
do
cat <<EOT
<li>$author ($count)
<ul>
$(author_table "$author")
</ul>
</li>
EOT
done < /tmp/.listed.txt
}


function start_loop() {
for x in $index_chars;
do
cat <<EOT
<li>$x
<ul>
$(start_index $x)
</ul>
</li>
EOT
done;
}


cat <<EOT
<ul>
$(start_loop)
</ul>
EOT
