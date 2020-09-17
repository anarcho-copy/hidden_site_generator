#!/bin/bash

##meta configs
generator="HTML generator BASH (bash-builtin), https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator";
robots_config="noindex,nofollow"

#website main title
site_title="Anarcho-Copy Hidden Site"
hidden_site=$(echo "http://$(grep -oP "server_name\s+\K\w+" ../web/site.conf 2>/dev/null).onion")
[ -f ../web/site.conf ] || hidden_site="";
base_href=$hidden_site ##not using at <!--force_base_href-->

#robots.txt config
function create_robots() {
cat > ../i/contents/robots.txt << EOF
User-Agent: *
Disallow: /
EOF
}

create_robots;

temp="../.tmp";

#set color
red="\e[1;31m";
redend="\e[0m";

#database config
data_base="../var/books.db";

#pdfs dir config
pdf_dir="/var/www/public/anarcho-copy.org/free"

#style
function print_style() {
cat <<EOT
<link href="/css/primer.css" rel="stylesheet" />
EOT
}
style=`echo "$(print_style)"`
######


zine_count=$(sqlite3 $data_base "SELECT status FROM books WHERE status IS 'zine';" | wc -l)
books_count=$(sqlite3 $data_base "SELECT status FROM books WHERE status IS NOT 'zine';" | wc -l)
total_count=$(sqlite3 $data_base "SELECT COUNT(*) FROM books;")
function name_encode() {
../src/urlencode.sh "$1"
}



#call url slug
url_slug="../src/slug_v0.2.2.sh"

#call convert.sh
convert_table="../src/convert.sh"


#listen copy dir
listenCopy="../i/listen/copy"

#rm listem copy
function rmListenCopy() {
rm -rf $listenCopy/*
}

#workDir
workdir="../i/out"

#workDir of /copy
workdirCopy="../i/out/copy"

#workDir of /pdf
workdirPdf="../i/out/pdf"

#TEMPLATE DIR
template="../i/template"

#rmdir pdf
function rmPdf() {
rm -rf $workdirPdf/*
}

#rmdir copy
function rmCopy() {
rm -rf $workdirCopy/*
}

#CREATE AUTHOR TABLE
function create_author_table() {
sqlite3 $data_base "SELECT url, author FROM author_books;" > $temp/authors_zines.txt;
}

#CREATE BOOKS TABLE /IS NOT ZINE
function create_books_table() {
sqlite3 $data_base "SELECT title,author,url,status FROM books WHERE status IS NOT 'zine'" > $temp/books_table.txt
}

#CREATE ALL BOOKS TABLE
function create_all_books() {
sqlite3 $data_base "SELECT title,author,url,subtitle,description,keywords,rowid,type,lang FROM books" > $temp/all_books.txt
}


#CREATE AUTHOR URL ARRAY
function create_url_array() {
i=0;
sqlite3 $data_base "SELECT url FROM author_books;" > $temp/author_urls.txt;
readarray -t url_array < $temp/author_urls.txt #create url array for next and prev
}

#create author name encoded array
function create_ae_array() {
i=0
readarray -t ae_array < $temp/author_encoded.txt #reading author encoded strings
}

#create all books url array for next and prev
function create_all_books_array() {
j=0
sqlite3 $data_base "SELECT url FROM books;" > $temp/only_titles.txt
readarray -t books_array  < $temp/only_titles.txt
}

function create_date_array() {
t=0
sqlite3 $data_base "SELECT date FROM books;" > $temp/dates.txt
readarray -t date_array < $temp/dates.txt
}

#LOOP FOR GEN HTML
function ifs_loop_az() {
while IFS="|" read -r url author
do
$1
done < $temp/authors_zines.txt
}

#LOOP FOR author books
function ifs_loop_ai() {
while IFS="|" read -r url title
do
$1
done < $temp/.author_index.txt;
}

#LOOP FOR without zines books
function ifs_loop_bt() {
while IFS="|" read -r title author url status;
do
$1
done < $temp/books_table.txt
}

#LOOP FOR all books
function ifs_loop_abt() {
while IFS="|" read -r title author url subtitle description keywords id type lang;
do
$1
$2
done < $temp/all_books.txt
}

#FIND AUTHOR BOOKS
function author_books_index() {
sqlite3 $data_base "SELECT url, title FROM books WHERE author LIKE '%$1%';" > $temp/.author_index.txt;
}


