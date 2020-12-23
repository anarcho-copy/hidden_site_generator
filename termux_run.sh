#!/bin/bash

cd "$(dirname "$0")";
. src/ask.sh #import the ask()
. i/template/tor.html.sh #import tor template page | tor.html()
. i/template/standalone.sh #import standalone html page | print_standalone()
. bin/config.sh &> /dev/null #import config
chmod 770 bin/*
chmod 770 i/template/*
chmod 770 src/*


#help page
function purge_guide() {
cat <<EOF
-p
   --delete     (it does not include the static contents)
   --delete-all (purge all files, it does include the static contents)
EOF
}
function guide() {
echo "usage: ./`basename $0` [-h] [-n] [-b|-c] [-g] [-r] [-t|-s] | [ -p --delete | --delete-all ]"
echo "-h       help page"
echo "-b       build html."
echo "-c       create static contents (as image etc.)"
echo "-g       generate the web site as use created files"
echo "-t       view tor adress"
purge_guide;
}


#build html files [-b] option
function build() {
rm -rf i/out/*;
mkdir -p i/out/{copy,pdf};
mkdir -p .tmp/;
bin/generate_author_pages.sh -gl
bin/generate_copy_files.sh -egl
bin/generate_websites_index.sh && echo "websites index page generated"
}


#create static contents [-c] option
function create() {
mkdir -p i/listen/copy
bin/generate_pdf_files.sh -iem #-c option is delete already created files
}



#generate the web site as use created files [-g option]
function main() {
mkdir -p public/;
chmod 0755 public/;
find public/free -type l -exec unlink {} \; &> /dev/null && echo "symbolic links removed"
rm -rf public/* &> /dev/null && echo "pages deleted"
mkdir public/free &> /dev/null && echo "pdf raw dir created"
cp -r i/out/* public/ && echo "i/out/* files are copied."
cp -r i/listen/copy/ public/ && echo "i/listen/copy/ dir copied"
cp -r i/contents/* public/ && echo "i/contents/* are copied"
ln -s $pdf_dir/* public/free && echo "/var/pdf/ symbolic link created"
tor.html > public/tor.html && echo "tor.html created"
print_standalone > public/print.html && echo "print.html created"
mkdir public/index && echo "index page creating.."
nohup bash src/index.sh > public/index/index.html &
find public/ -type f -exec chmod 0644 {} \; &> /dev/null && echo "files permissions setted"
find public/ -type d -exec chmod 0755 {} \; &> /dev/null && echo "directory permissions setted"
}



#purge everything [-p] option
function purge() {
function delete_default() {
rm -rf i/out/* && echo "i/out/* are deleted";
rm -rf public/* && echo "public/* are deleted";
rm -rf .tmp/* && echo ".tmp/* are deleted";
find -path '.tmp/.*' -delete && echo ".tmp/.* are deleted";
}

function delete_static() {
rm -rf i/listen/copy/* && echo "i/listen/* are deleted";
}

 case $purge_arg in
    --delete)
    delete_default
    ;;
    --delete-all)
    delete_default
	if ask "do you want the delete static files?" N; then
	    delete_static;
	else
	    echo "--delete-all option is bypassed"
	fi
    ;;
    *)
    echo "unknown option: $purge_arg"
    purge_guide;
    ;;
 esac

}


while getopts ":hbcgtp:" opt; do
  case ${opt} in
    h ) guide;
      ;;
    b ) build;
      ;;
    c ) create;
      ;;
    g ) main;
      ;;
    t ) cat web/hostname 2>/dev/null || echo "tor address not defined in web/hostname";
      ;;
    p )
      purge_arg=${OPTARG}
      purge
      ;;
    : )
      echo "Missing option argument for -$OPTARG [ --default | --all ]"
      purge_guide
      ;;
  esac
done


if [ "$#" -lt 1 ]; then
    guide;
fi
