#!/bin/bash
#START
res1=$(date +%s.%N)

cd "$(dirname "$0")"
cd ../bin/;
. config.sh; #import
cd - &> /dev/null

db_file="../var/books.db";

index_chars="1 A B C Ç D E F G Ğ I İ J K L M N O Ö P R S Ş T U Ü V W Y Z";

#CGI-Bash compatible
#echo "Content-type: text/html"
#echo ""

function author_index() {
sqlite3 $db_file "SELECT author FROM books WHERE author LIKE '$1%'" > /tmp/.list.txt
sort /tmp/.list.txt | uniq -ci > /tmp/.listed.txt
while IFS=" " read -r count author
do
cat <<EOT
<a href="/index/#$(cat /tmp/.author_count)">$author</a> ($count),
EOT
 echo "$((  $(cat /tmp/.author_count) + 1 ))" > /tmp/.author_count 
done < /tmp/.listed.txt
}


function author_loop() {
echo "0" > /tmp/.author_count
for x in $index_chars;
do
cat <<EOT
$(author_index $x)
EOT
done;
}



###########################3

function author_table() {
sqlite3 $db_file "SELECT title,url FROM books WHERE author IS '$1'" > /tmp/.table.txt
while IFS="|" read -r title url
do
cat <<EOT
<li><a href="/copy/$url/">$title</a></li>
EOT
done < /tmp/.table.txt
}


function start_index() {
sqlite3 $db_file "SELECT author FROM books WHERE author LIKE '$1%'" > /tmp/.list.txt
sort /tmp/.list.txt | uniq -ci > /tmp/.listed.txt
while IFS=" " read -r count author
do
cat <<EOT
<li id="$(cat /tmp/.id_count)"><span id="$(echo "$author" | bash $url_slug )">$author ($count)</span>
<ul>
$(author_table "$author")
</ul>
</li>
EOT
 echo "$((  $(cat /tmp/.id_count) + 1 ))" > /tmp/.id_count 
done < /tmp/.listed.txt
}


function start_loop() {
echo "0" > /tmp/.id_count
for x in $index_chars;
do
cat <<EOT
<div id="$x">
<li><h1>$x</h1>
<ul>
$(start_index $x)
</ul>
</li>
</div>
<br>
EOT
done;
}

function letters() {
for x in $index_chars;
do
cat <<EOT
 <a href="/index/#$x">$x</a>&nbsp;
EOT
done;
}

cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--force_base_href-->
<title>Kapsamlı İndex</title>
$style
<style>
body {
color:black;
background-color:white;
}
#letters a { color: red; font-size: 25px;}
#author a { color: blue; text-decoration: none;}
</style>
</head>
<body class="bg-gray">
<div id="holy" class="container-lg bg-white h-100">
    <div id="header" class="px-1 bg-white">
        <nav class="UnderlineNav UnderlineNav--right px-2">
        <a class="UnderlineNav-actions muted-link h2" href="/index.html">
    $site_title</a>
       </nav>
   </div>
<br>
<div role="main" id="main" class="holy-main markdown-body px-4 bg-white">
<div id="author">
$(author_loop)
</div>
<hr>
<div id="letters">
$(letters)
</div>
<hr>
<ul>
$(start_loop)
</ul>
EOT


res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)

echo "<hr>"
LC_NUMERIC=C printf 'Page build by <a href="/tools/index.sh.html">Bash script</a> in about %02.4f seconds\n' $ds

echo -ne "</br></br></div>\n</div>\n</body>\n</html>"

##END

