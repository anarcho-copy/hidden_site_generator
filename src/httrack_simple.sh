#!/bin/bash
# https://github.com/rojenzaman/site-archiver
#
# Copy(A)
# No Copyright / Anti-Copyright

# That script not for "html generator".
#
## You don't have to install httrack..

###config###
dir="/var/www/public/anarcho-copy.org/yedeklenen-siteler/";
############

#variables
url=$1;
title=$2;
filename=archive-$(date +"%Y-%m-%d_%H-%M_%S").log;

#check strings
function param() {
[ -z "$url" ] &&  guide;
[ -z "$title" ] && guide;
}

#man page
function guide() {
    echo -e "usage: ./`basename $0` SITE-URL \"TITLE\"";
    exit 1;
}

#httrack control
function call_httrack() {
    dpkg -s httrack &> /dev/null || echo "httrack not installed, please install httrack and run it." || exit 1;
}

#httrack command
function run() {
nohup httrack $url -O $dir/"$title" -%v > $filename &
}

#value sufficiency entered while running the script
if [ "$#" -lt 1 ]; then
    guide;
fi

if [ "$#" -gt 2 ];then
    guide;
fi

#called param for check strings
param;

#run httrack control
call_httrack && echo -e "using httrack..\n";

echo "$url";
echo -e "$title\n";

echo "starting...";

#run httrack
run &> /dev/null;


echo -e "\n logs are in $filename file";
