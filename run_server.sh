#!/bin/bash

cd "$(dirname "$0")";
. src/ask.sh #import the ask()
. i/template/tor.html.sh #import tor template page | tor.html()
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
   --web        (delete web/ files)
EOF
}
function guide() {
echo "usage: ./`basename $0` [-h] [-n] [-b|-c] [-g] [-r] [-t|-s] | [ -p --default | --all | --web ]"
echo "-h       help page"
echo "-n       generate new tor address"
echo "-b       build html."
echo "-c       create static contents (as image etc.)"
echo "-g       generate the web site as use created files"
echo "-r       run tor server/container"
echo "-t       view tor adress"
echo "-s       status"
purge_guide;
}


#generate new tor adress [-n] option
function new_address() {
function run_new_address() {
rm -rf web/;
mkdir web;
docker run -it --rm -v $(pwd)/web:/web tor-docker generate ^copy && echo "tor address is generated";
}
if ask "do you want the generate new tor address?" N; then

    run_new_address;
else
    echo "okay."
fi
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
mkdir public/index && echo "index page creating.."
nohup bash src/index.sh > public/index/index.html &
find public/ -type f -exec chmod 0644 {} \; &> /dev/null && echo "files permissions setted"
find public/ -type d -exec chmod 0755 {} \; &> /dev/null && echo "directory permissions setted"
}


#run tor server/container [-r] option
function tor_server() {
function start_tor_server() {
docker rm hiddensite -f &> /dev/null; #for security deleting the old container
docker run -d --restart=always -h "onion-service" --network="host" --name hiddensite -v $(pwd)/web:/web tor-docker;
}
start_tor_server && echo "tor server is running.. hostname: $(grep -oP "server_name\s+\K\w+" web/site.conf).onion"
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
    --web)
        if ask "do you want the delete web files?" N; then
            rm -rf web/ && echo "web/ directory is deleted";
        else
            echo "--web option is bypassed";
        fi
    ;;
    *)
    echo "unknown option: $purge_arg"
    purge_guide;
    ;;
 esac

}



while getopts ":hnbcgrp:ts" opt; do
  case ${opt} in
    h ) guide;
      ;;
    n ) new_address;
      ;;
    b ) build;
      ;;
    c ) create;
      ;;
    g ) main;
      ;;
    r ) tor_server;
      ;;
    p )
      purge_arg=${OPTARG}
      purge
      ;;
    t )
      if [ -f "web/site.conf" ]; then
         echo -e "$(grep -oP "server_name\s+\K\w+" web/site.conf).onion"
      else
         echo -e "\033[31mplease first generate new tor adress!\e[0m  ./`basename $0` -n "
      fi
      ;;
    s )
      docker exec -it hiddensite service nginx status
      docker exec -it hiddensite service tor status
      docker exec -it hiddensite ps aux|grep tor
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

