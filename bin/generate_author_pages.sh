#!/bin/bash
cd "$(dirname "$0")"

. config.sh #import
. $template/generate_author_pages_html.sh  #import

function out1() { echo -e "${red}generated ${redend}$url"; }
function out2() { echo "an error occurred when reading $data_base"; }
function out3() { echo "an error occurred when creating files and directories"; }

function guide() {
echo "usage: ./`basename $0` [-l] [-g]"
}

function generate_dir() {
mkdir $workdirPdf/$url/ && out1;

#searching books by author name
author_books_index $author || out2; #saving as .generate_author_pages_html.txt #FROM CONFIG.SH

generate_author_pages_html > $workdirPdf/$url/index.html # ifs_loop_ai generate_html; generate_author_pages_html is from generate_author_pages_html.sh
}

function generate() {
create_author_table;
create_url_array; #crete url array for next and prev
create_books_table; #creating autor tables for parsing | from config.sh
rmPdf && ifs_loop_az generate_dir || out3; #ifs_loop_az from config.sh for parsing
}

while getopts ":lg" opt; do
  case ${opt} in
    l ) . author_index.sh #has a
      ;;
    g ) generate
      ;;
    \? ) guide
      ;;
  esac
done


if [ "$#" -lt 1 ]; then
    guide;
fi

