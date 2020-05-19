#!/bin/bash

function guide() {
echo "usage: ./`basename $0` [-b|-c] [r]"
echo "-b       build html."
echo "-c       create static contents (as image etc.)"
echo "-r       run server"
}

function build() {
bin/generate_author_pages.sh -gl
bin/generate_copy_files.sh -egl
bin/generate_websites_index.sh && echo "websites index page generated"
}

function create() {
bin/generate_pdf_files.sh -ciem #-c option is delete already created files
}

function main() {
rm -rf public/* &> /dev/null && echo "pages deleted"
cp -r i/out/* public/ && echo "i/out/* files are copied."
cp -r i/listen/copy/ public/ && echo "i/listen/copy/ dir copied"
cp -r i/contents/* public/ && echo "i/manual-contents/* are copied"
ln -s /var/www/public/anarcho-copy.org/free/ public/ && echo "/var/www/public/anarcho-copy.org/free/ symbolic link created"
mkdir public/index && echo "index page creating.."
nohup bash src/index.sh > public/index/index.html &
python3 -m http.server --directory public/
}



while getopts ":rbc" opt; do
  case ${opt} in
    r ) main;
      ;;
    b ) build;
      ;;
    c ) create;
      ;;
    \? ) guide;
      ;;
  esac
done

if [ "$#" -lt 1 ]; then
    guide;
fi


