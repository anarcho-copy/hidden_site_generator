#!/bin/bash
#subclass of generate_copy_files.sh

function article_html() {

. config.sh #import

sqlite3 $data_base "SELECT id FROM article_html;" > $temp/.ids.txt

while IFS= read -r id;
do
rowID=$(sqlite3 $data_base "SELECT rowid FROM books WHERE id is '$id'")
article["$rowID"]=$(sqlite3 $data_base "SELECT code FROM article_html WHERE id is '$id'" | awk '{print}' ORS='\\n')
done < $temp/.ids.txt

}
