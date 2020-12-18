#!/bin/bash
#printer friendly

#config
link="https://anarcho-copy.org"
pwd="https://build.anarcho-copy.org"

cd "$(dirname "$0")"
cd ../bin/;
. config.sh; #import
cd - &> /dev/null
db_file="../var/books.db";

index_chars="1 2 A B C Ç D E F G Ğ H I İ J K L M N O Ö P Q R S Ş T U Ü V W X Y Z";


function author_table() {
sqlite3 $db_file "SELECT title,url FROM books WHERE author IS '$1'" > /tmp/.table.txt
while IFS="|" read -r title url
do
cat <<EOT
<li><a href="$link/free/$url.pdf">$title</a></li>
EOT
done < /tmp/.table.txt
}


function start_index() {
sqlite3 $db_file "SELECT author FROM books WHERE author LIKE '$1%'" > /tmp/.list.txt
sort /tmp/.list.txt | uniq -ci > /tmp/.listed.txt
while IFS=" " read -r count author
do
id=$(echo "$author" | bash $url_slug);
cat <<EOT
<div class="author-name">
<li id="$id"><a href="$pwd/print.html#$id">$author</a> ($count)
</div>
<ul class="book-name">
$(author_table "$author")
</ul>
</li>
<br/>
EOT
done < /tmp/.listed.txt
}


function start_loop() {
for x in $index_chars;
do
cat <<EOT
<li id="$x">$x
<ul>
$(start_index $x)
</ul>
</li>
<br/><br/>
EOT
done;
}


function letters() {
for x in $index_chars;
do
cat <<EOT
 <a href="print.html#$x">$x</a>&nbsp;
EOT
done;
}


cat <<EOT
<div id="letters" class="letters">
$(letters)
</div>
<div id="index">
<ul>
$(start_loop)
</ul>
</div>
EOT
