#!/bin/bash

function guide() {
cat <<EOF
usage: ./`basename $0` -f <database.db>
[-i <UUID> new ] (if you give 'new' argument, it will be created auto)
[-t TITLE]
[-a AUTHOR]
[-u URL]
[-s STATUS]
[-d DATE]
[-l LANG]
[-x TYPE]
[-k KEYWORDS (seperated by commas)]
[-y DESCRIPTION]
[-z SUBTITLE]
  -v (verbose and column output)
EOF
exit 0;
}

_check_id() {
if [ "$id" == "new" ]
then
  id=`echo "uuid:$(cat /proc/sys/kernel/random/uuid)"`;
fi
}

_verbose() {
echo ""
cat <<EOF | column -t -s"|"
id |title |author |url |status |date |lang |type |keywords |description |subtitle
$id|$title|$author|$url|$status|$date|$lang|$type|$keywords|$description|$subtitle
EOF
echo ""
}

while getopts ":f:i:t:a:u:s:d:l:x:k:y:z:v" opt; do
  case ${opt} in
    f )
      db=${OPTARG};
      ;;
    i )
      id=${OPTARG};
	_check_id;
      ;;
    t )
      title=${OPTARG};
      ;;
    a )
      author=${OPTARG};
      ;;
    u )
      url=${OPTARG};
      ;;
    s )
      status=${OPTARG};
      ;;
    d )
      date=${OPTARG};
      ;;
    l )
      lang=${OPTARG};
      ;;
    x )
      type=${OPTARG};
      ;;
    k )
      keywords=${OPTARG};
      ;;
    y )
      description=${OPTARG};
      ;;
    z )
      subtitle=${OPTARG};
      ;;
    v )
       _verbose;
      ;;
    : )
      echo "Missing option argument for -$OPTARG"
      exit 0;
      ;;
  esac
done

if [ "$#" -lt 1 ]; then
    guide;
fi

if [ -z "$db" ]
 then
   echo "database not specified.";
   echo "aborting";
   exit 0;
 else
   sqlite3 $db "INSERT INTO books (id,title,author,url,status,date,lang,type,keywords,description,subtitle) \
   VALUES ('$id','$title','$author','$url','$status','$date','$lang','$type','$keywords','$description','$subtitle');";
fi

cat <<EOF
id            : '$id'
title         : '$title'
author        : '$author'
url           : '$url'
status        : '$status'
date          : '$date'
lang          : '$lang'
type          : '$type'
keywords      : '$keywords'
description   : '$description'
subtitle      : '$subtitle'
EOF
