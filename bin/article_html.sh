#!/bin/bash
#subclass of generate_copy_files.sh

function article_html() {

. config.sh #import

sqlite3 $data_base "SELECT id FROM article_html;" > $temp/.ids.txt

while IFS= read -r id;
do
article[$id]=$(sqlite3 $data_base "SELECT code FROM article_html WHERE id is '$id'" | awk '{print}' ORS='\\n')
article[$id]="<div class=\"article\">\n${article[$id]}</div>"
done < $temp/.ids.txt

}
