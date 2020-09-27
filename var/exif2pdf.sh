#!/bin/bash

signature="Anarcho-Copy Collective (anarcho-copy.org)"; # -Producer
default_lang="tr";

function guide() {
cat <<EOF
usage: ./`basename $0` -f <filename.pdf> [-o (when values are not given, set value to null)]
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

_set_null() {
#-o argument
[ -z "$id" ]          && id="null";
[ -z "$title" ]       && title="null";
[ -z "$author" ]      && author="null";
[ -z "$url" ]         && url="null";
[ -z "$status" ]      && status="null";
[ -z "$date" ]        && date="$(date '+%Y:%m:%d %T')";
[ -z "$lang" ]        && lang="$default_lang";
[ -z "$type" ]        && type="null";
[ -z "$keywords" ]    && keywords="null";
[ -z "$description" ] && description="null";
[ -z "$subtitle" ]    && subtitle="null";
}

_check_id() {
#-i argument. when given 'new', uuid will be created auto.
if [ "$id" == "new" ]
then
  id=`echo "uuid:$(cat /proc/sys/kernel/random/uuid)"`;
fi
}

_verbose() {
#-v argument, verbose output
echo ""
cat <<EOF | column -t -s"|"
id |title |author |url |status |date |lang |type |keywords |description |subtitle
$id|$title|$author|$url|$status|$date|$lang|$type|$keywords|$description|$subtitle
EOF
echo ""
}

#check arguments
while getopts ":f:oi:t:a:u:s:d:l:x:k:y:z:v" opt; do
  case ${opt} in
    f )
      file=${OPTARG};
      ;;
    o )
      _set_null;
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

#when file not given terminated the process.
if [ -z "$file" ]
 then
   echo "file name not specified.";
   echo "aborting";
   exit 0;
#if not start the main process.
 else
   if [ ! -f "$file" ]
     then
       echo "file not found.";
       echo "aborting";
       exit 0;
     else
       exiftool -m \
        -DocumentID="$([ -z "$id" ] || echo uuid:$id)" -Title="$title" \
        -Author="$author" -Source="$url" \
        -Status="$status" -Date="$date" \
        -Language="$lang" -Type="$type" \
        -Keywords="$keywords" -Description="$description" \
        -State="$subtitle" -Producer="$signature" "$file";
   fi
fi

cat <<EOF
DocumentID    : '$id'
Title         : '$title'
Author        : '$author'
Source        : '$url'
Status        : '$status'
Date          : '$date'
Language      : '$lang'
Type          : '$type'
Keywords      : '$keywords'
Description   : '$description'
State         : '$subtitle'
Producer      : '$signature'
EOF
