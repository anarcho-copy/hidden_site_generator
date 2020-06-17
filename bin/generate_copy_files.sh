#!/bin/bash
cd "$(dirname "$0")";

. config.sh #import
. article_html.sh #import
. $template/copy_page.sh  #import

function out1() { echo -e "${red}generated ${redend}$url"; }
function out2() { echo "an error occurred when reading $data_base"; }
function out3() { echo "an error occurred when creating files and directories"; }

function guide() {
echo "usage: ./`basename $0` [-l] [-g] [-e]"
}

function generate_dir() {
mkdir $workdirCopy/$url/ && out1;

copy_page > $workdirCopy/$url/index.html
}

function generate() {
article_html; #create article html array
create_date_array; #for show page creating date
create_all_books_array; #for next and prev
create_ae_array; #for encoded author names
create_all_books || out2;

rmCopy && ifs_loop_abt generate_dir || out3;

}

while getopts ":lge" opt; do
  case ${opt} in
    l ) . books_index_without_zines.sh #has a
      ;;
    g ) generate;
      ;;
    e ) . author_decode.sh; #call
      ;;
    \? ) guide;
      ;;
  esac
done


if [ "$#" -lt 1 ]; then
    guide;
fi

