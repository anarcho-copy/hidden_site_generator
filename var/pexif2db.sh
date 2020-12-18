#!/bin/bash

function guide() {
echo "usage: `basename $0` <filename.pdf>"
}

file="$1"
script_dir=$(dirname $(readlink -f $0))
db=$script_dir/books.db

[ -f "$1" ] && {

id=`exiftool -s -s -s -DocumentID $file`
title=`exiftool -s -s -s -Title $file`
author=`exiftool -s -s -s -Author $file`
url=`exiftool -s -s -s -Source $file`
status=`exiftool -s -s -s -Status $file`
date=`exiftool -s -s -s -Date $file`
lang=`exiftool -s -s -s -Language $file`
type=`exiftool -s -s -s -Type $file`
keywords=`exiftool -s -s -s -Keywords $file`
description=`exiftool -s -s -s -Description $file`
subtitle=`exiftool -s -s -s -State $file`
signature=`exiftool -s -s -s -Producer $file`

$script_dir/create_record.sh -f "$db" \
 -i "$id" -t "$title" \
 -a "$author" -u "$url" \
 -s "$status" -d "$date" \
 -l "$lang" -x "$type" \
 -k "$keywords" -y "$description" \
 -z "$subtitle" -v

}

if [ "$#" -lt 1 ]; then
    guide;
fi
